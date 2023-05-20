class ChatMessage {
  final String id;
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.timestamp,
  });

  // Map model to Firestore document
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp,
    };
  }

    // Create model from Firestore document
    factory ChatMessage.fromMap(Map<String, dynamic> map) {
      return ChatMessage(
        id: map['id'],
        senderId: map['senderId'],
        receiverId: map['receiverId'],
        message: map['message'],
        timestamp: map['timestamp'].toDate(),
      );
    }
}
