import 'package:e_ciftcim/screens/sign_in/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ProfileMenuItem {
  final String text;
  final String icon;
  final void Function(BuildContext?)? onPressed;

  ProfileMenuItem({
    required this.text,
    required this.icon,
    this.onPressed,
  });
}

class ProfileMenuItems {
  static final List<ProfileMenuItem> menuItems = [
    ProfileMenuItem(
      text: "Hesabım",
      icon: "assets/icons/User Icon.svg",
      onPressed: (context) {
        // Handle onPressed logic
      },
    ),
     ProfileMenuItem(
      text: "Hesabım",
      icon: "assets/icons/User Icon.svg",
      onPressed: (context) {
        // Handle onPressed logic
      },
    ),
       ProfileMenuItem(
      text: "Hesabım",
      icon: "assets/icons/User Icon.svg",
      onPressed: (context) {
        // Handle onPressed logic
      },
    ),
    ProfileMenuItem(
      text: "Bildirimler",
      icon: "assets/icons/Bell.svg",
      onPressed: null,
    ),
    ProfileMenuItem(
      text: "Ayarlar",
      icon: "assets/icons/Settings.svg",
      onPressed: (context) {
        // Handle onPressed logic
      },
    ),
    ProfileMenuItem(
      text: "Yardım Merkezi",
      icon: "assets/icons/Question mark.svg",
      onPressed: null,
    ),
    ProfileMenuItem(
      text: "Çıkış Yap",
      icon: "assets/icons/Log out.svg",
      onPressed: (context) async {
        try {
          await FirebaseAuth.instance.signOut();
        } catch (e) {
          print("Error signing out: $e");
        }
        User? user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          Navigator.pushReplacement(
            context!,
            MaterialPageRoute(builder: (context) => SignInScreen()),
          );
        }
      },
    ),
  ];
}