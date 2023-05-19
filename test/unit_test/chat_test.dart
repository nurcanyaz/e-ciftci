import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:../models/ChatMessages.dart';
import 'package:../lib/models/ChatMessages.dart';
import '../controllers/ChatController.dart';

// Create a mock FirebaseFirestore instance
class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
  late ChatController chatController;
  late MockFirebaseFirestore mockFirestore;

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    chatController = ChatController();
    chatController._firestore = mockFirestore;
  });

  test('saveMessage should save a message to Firestore', () async {
    // Create a test ChatMessage
    final chatMessage = ChatMessage(
      id: 'message1',
      senderId: 'senderId',
      receiverId: 'receiverId',
      timestamp: DateTime.now(),
      // Other required properties...
    );

    // Stub the Firestore method
    when(mockFirestore.collection(any)).thenReturn(mockCollectionReference);
    when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
    when(mockDocumentReference.set(any)).thenAnswer((_) async {});

    // Call the saveMessage method
    await chatController.saveMessage(chatMessage);

    // Verify that the Firestore method was called with the correct parameters
    verify(mockFirestore.collection('messages')).called(1);
    verify(mockCollectionReference.doc('message1')).called(1);
    verify(mockDocumentReference.set(chatMessage.toMap())).called(1);
  });

  test('getChatMessages should return a stream of chat messages', () {
    // Create test data
    final userId1 = 'user1';
    final userId2 = 'user2';
    final querySnapshot1 = MockQuerySnapshot();
    final querySnapshot2 = MockQuerySnapshot();

    // Stub the Firestore method
    when(mockFirestore.collection('messages')).thenReturn(mockCollectionReference);
    when(mockCollectionReference.where('senderId', isEqualTo: userId1)).thenReturn(mockQuery1);
    when(mockQuery1.where('receiverId', isEqualTo: userId2)).thenReturn(mockQuery1);
    when(mockQuery1.orderBy('timestamp', descending: true)).thenReturn(mockQuery1);
    when(mockQuery1.snapshots()).thenAnswer((_) => Stream.value(querySnapshot1));

    when(mockFirestore.collection('messages')).thenReturn(mockCollectionReference);
    when(mockCollectionReference.where('senderId', isEqualTo: userId2)).thenReturn(mockQuery2);
    when(mockQuery2.where('receiverId', isEqualTo: userId1)).thenReturn(mockQuery2);
    when(mockQuery2.orderBy('timestamp', descending: false)).thenReturn(mockQuery2);
    when(mockQuery2.snapshots()).thenAnswer((_) => Stream.value(querySnapshot2));

    // Create mock documents
    final documentData1 = {
      'senderId': userId1,
      'receiverId': userId2,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      // Other required properties...
    };
    final documentData2 = {
      'senderId': userId2,
      'receiverId': userId1,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      // Other required properties...
    };
    final document1 = MockDocumentSnapshot();
    final document2 = MockDocumentSnapshot();
    when(document1.data()).thenReturn(documentData1);
    when(document2.data()).thenReturn(documentData2);
    when(querySnapshot1.docs).thenReturn([document1]);
    when(querySnapshot2.docs).thenReturn([document2]);

    // Call the getChatMessages method
    final chatMessagesStream = chatController.getChatMessages(userId1, userId2);

    //
