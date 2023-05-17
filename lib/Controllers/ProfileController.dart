import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_ciftcim/Controllers/UserController.dart';
import 'package:e_ciftcim/models/Profile.dart' as prefix;

class UserProfileController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUserProfile(String uid) async {
    await _firestore.collection('profiles').doc(uid).set({
      'UID': uid,
      'fName': null,
      'lName': null,
      'telno': null,
      'seller': false,
      'username': null,
      'sex': null,
      'icon': null,

    });
  }

  Future<void> updateProfile(String uid, Map<String, dynamic> data) async {
    await _firestore.collection('profiles').doc(uid).update(data);
  }

  Future<Map<String, dynamic>> getUserProfile(String userId) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
    await _firestore.collection('profiles').doc(userId).get();

    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data()!;
      return data;
    } else {
      throw Exception('User profile not found');
    }
  }

  Future<bool> isFieldNull(String userId, String field) async {
    Map<String, dynamic> userProfile = await getUserProfile(userId);
    return userProfile[field] == null;
  }



  Stream<List<prefix.Profile>>? getProfileStream() async* {
    UserController userController= UserController();
    String? currentUserId = await userController.getCurrentUserId();
    if (currentUserId == null) {
      throw Exception('No user is currently signed in');
    }
    yield* _firestore
        .collection('profiles')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .where((doc) => doc.id != currentUserId)
          .map<prefix.Profile>((doc) => prefix.Profile.fromFirestore(doc.data()))
          .toList();
    });
  }


  Future<int> getProfileNumber() async {
    QuerySnapshot querySnapshot = await _firestore.collection('profiles').get();
    return querySnapshot.docs.length; // Subtract 1 to exclude the current user
  }
}




