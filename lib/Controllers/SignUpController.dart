import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_ciftcim/Controllers/ProfileController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class SignUpController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;



  void showAccountCreatedToast() {
    Fluttertoast.showToast(
      msg: 'Hesap oluşturuldu',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
  void showErrorToast(e) {
    Fluttertoast.showToast(
      msg: e,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }



  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      final userCredentials = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = await FirebaseAuth.instance.currentUser;

        FirebaseFirestore _firestore = FirebaseFirestore.instance;
        await _firestore.collection('users').doc(user!.uid).set({
          'UID': user.uid,
          'email': user.email,

        });
        UserProfileController profileController= UserProfileController();
        profileController.createUserProfile(user.uid);
        showAccountCreatedToast();

    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
          showErrorToast('E-posta zaten kullanımda');
        } else {
          // Other FirebaseAuthException error
          print('Error: ${e.code}');
        }
      } else {
        // Other error occurred
        print('Error: $e');
      }
    }
   




    }}