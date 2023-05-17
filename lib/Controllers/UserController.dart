import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_ciftcim/models/User.dart' as prefix;

class UserController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> getCurrentUserId() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return null;
    }
  }

  Stream<List<prefix.User>>? getUsersStream() async* {
    String? currentUserId = await getCurrentUserId();
    if (currentUserId == null) {
      throw Exception('No user is currently signed in');
    }
    yield* _firestore
        .collection('users')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .where((doc) => doc.id != currentUserId)
          .map<prefix.User>((doc) => prefix.User.fromId(doc.id))
          .toList();
    });
  }


  Future<int> getUsersNumber() async {
    QuerySnapshot querySnapshot = await _firestore.collection('users').get();
    return querySnapshot.docs.length; // Subtract 1 to exclude the current user
  }
}