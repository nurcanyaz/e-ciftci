import 'package:e_ciftcim/screens/sign_in/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../complete_profile/complete_profile_screen.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "Hesabım",
            icon: "assets/icons/User.dart Icon.svg",
            press: () => {Navigator.pushNamed(context, CompleteProfileScreen.routeName)},
          ),
          ProfileMenu(
            text: "Bildirimler",
            icon: "assets/icons/Bell.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Ayarlar",
            icon: "assets/icons/Settings.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Yardım Merkezi",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Çıkış Yap",
            icon: "assets/icons/Log out.svg",
            press: () async{
              try {
                await FirebaseAuth.instance.signOut();


              } catch (e) {
                print("Error signing out: $e");
              }
              User? user =  FirebaseAuth.instance.currentUser;
              if(user==null){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInScreen()));

              }

            },
          ),
        ],
      ),
    );
  }
}
