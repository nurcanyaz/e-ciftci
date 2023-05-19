import 'package:e_ciftcim/models/ProfileMenuItems.dart';
import 'package:e_ciftcim/models/Profile.dart';
import 'package:e_ciftcim/screens/sign_in/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../complete_profile/complete_profile_screen.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  final List<ProfileMenuItem> menuItems=ProfileMenuItems.menuItems;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          Container(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                return ProfileMenu(
                  text: menuItems[index].text,
                  icon: menuItems[index].icon,
                  press: () => menuItems[index].onPressed?.call(context),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
