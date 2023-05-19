import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/ChatMessages.dart';
import 'package:rxdart/rxdart.dart';
class ChatController {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Save a message to Firestore
  Future<void> saveMessage(ChatMessage chatMessage) async {
    await _firestore.collection('messages').doc(chatMessage.id).set(chatMessage.toMap());
  }

  // Get chat messages between two users
  Stream<List<ChatMessage>> getChatMessages(String userId1, String userId2) {
    Stream<QuerySnapshot> stream1 = _firestore
        .collection('messages')
        .where('senderId', isEqualTo: userId1)
        .where('receiverId', isEqualTo: userId2)
        .orderBy('timestamp', descending: true)
        .snapshots();

    Stream<QuerySnapshot> stream2 = _firestore
        .collection('messages')
        .where('senderId', isEqualTo: userId2)
        .where('receiverId', isEqualTo: userId1)
        .orderBy('timestamp', descending: false)
        .snapshots();

    return Rx.combineLatest2<QuerySnapshot, QuerySnapshot, List<ChatMessage>>(
      stream1,
      stream2,
          (QuerySnapshot snapshot1, QuerySnapshot snapshot2) {
        List<ChatMessage> chatMessages = [];
        chatMessages.addAll(snapshot1.docs.map((doc) => ChatMessage.fromMap(doc.data() as Map<String, dynamic>)).toList());
        chatMessages.addAll(snapshot2.docs.map((doc) => ChatMessage.fromMap(doc.data() as Map<String, dynamic>)).toList());

        // Sorting the messages by timestamp after merging.
        chatMessages.sort((a, b) => b.timestamp.compareTo(a.timestamp));
        return chatMessages;
      },
    );
  }


  //get Last message between users
  Future<ChatMessage?> getLastChatMessage(String userId1, String userId2) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('messages')
        .where('senderId', whereIn: [userId1, userId2])
        .where('receiverId', whereIn: [userId1, userId2])
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return ChatMessage.fromMap(querySnapshot.docs.first.data as Map<String, dynamic>);
    } else {
      return null;
    }
  }



}
