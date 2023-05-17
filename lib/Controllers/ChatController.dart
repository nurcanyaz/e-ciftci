import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/ChatMessages.dart';

class ChatController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Save a message to Firestore
  Future<void> saveMessage(ChatMessage chatMessage) async {
    await _firestore.collection('messages').doc(chatMessage.id).set(chatMessage.toMap());
  }

  // Get chat messages between two users
  Stream<List<ChatMessage>> getChatMessages(String userId1, String userId2) {
    return _firestore
        .collection('messages')
        .where('senderId', isEqualTo: userId1)
        .where('receiverId', isEqualTo: userId2)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return ChatMessage.fromMap(doc.data());
      }).toList();
    });
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
