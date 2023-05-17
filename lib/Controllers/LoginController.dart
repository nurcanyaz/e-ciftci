import 'package:e_ciftcim/Controllers/ProfileController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../helper/keyboard.dart';
import '../screens/complete_profile/complete_profile_screen.dart';
import '../screens/login_success/login_success_screen.dart';

class LoginController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> signInWithEmailAndPassword(context, String email, String password) async {
    signOut();
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
        KeyboardUtil.hideKeyboard(context);
        UserProfileController profileController = new UserProfileController();
        final isNull= await profileController.isFieldNull(user!.uid,'username');
        if(isNull){
          Navigator.pushNamed(context, CompleteProfileScreen.routeName);

        }
        else{
          Navigator.pushNamed(context, LoginSuccessScreen.routeName);
        }
      // if all are valid then go to success screen

    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'wrong-password') {
          showErrorToast('Parola geçersiz veya kullanıcı yok.');
        } else {
          // Handle other FirebaseAuthException errors
          print('Error: ${e.code}');
        }
    }
  }}
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

  Future<void> signOut() async {
    await _auth.signOut();
  }






}
