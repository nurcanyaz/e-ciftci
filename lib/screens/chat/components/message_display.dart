import 'package:e_ciftcim/Controllers/ProfileController.dart';
import 'package:e_ciftcim/components/custom_surfix_icon.dart';
import 'package:e_ciftcim/components/form_error.dart';
import 'package:e_ciftcim/helper/keyboard.dart';
import 'package:e_ciftcim/screens/chat/components/chat_form.dart';
import 'package:e_ciftcim/models/Profile.dart' as prefix;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../Controllers/UserController.dart';
import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../models/Profile.dart';
import '../../../size_config.dart';

class MessagePanelDisplay extends StatelessWidget {
  MessagePanelDisplay({Key? key}) : super(key: key);

  final UserController userController = UserController();
  final UserProfileController profileController = UserProfileController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Profile>>(
      stream: profileController.getProfileStream(),
      builder: (BuildContext context, AsyncSnapshot<List<Profile>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Container(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                final toUser = snapshot.data![index];
                return FutureBuilder<String?>(
                  future: userController.getCurrentUserId(),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (userSnapshot.hasError) {
                      return Text('Error: ${userSnapshot.error}');
                    } else {
                      final fromUser = userSnapshot.data;
                      if (fromUser != null) {
                        return FutureBuilder<Map<String, dynamic>>(
                          future: profileController.getUserProfile(toUser.uid),
                          builder: (context, toProfileSnapshot) {
                            if (toProfileSnapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (toProfileSnapshot.hasError) {
                              return Text('Error: ${toProfileSnapshot.error}');
                            } else {
                              return FutureBuilder<Map<String, dynamic>>(
                                future: profileController.getUserProfile(fromUser),
                                builder: (context, fromProfileSnapshot) {
                                  if (fromProfileSnapshot.connectionState == ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else if (fromProfileSnapshot.hasError) {
                                    return Text('Error: ${fromProfileSnapshot.error}');
                                  } else {
                                    return buildChatPanel(
                                      fromProfileSnapshot.data!,
                                      toProfileSnapshot.data! as Map<String, dynamic>,
                                      context,
                                    );
                                  }
                                },
                              );
                            }
                          },
                        );
                      } else {
                        return Text('Error: Current user ID is null');
                      }
                    }
                  },
                );
              },
            ),
          );
        }
      },
    );
  }

  Padding buildChatPanel(Map<String, dynamic> profileFrom, Map<String, dynamic> profileTo, context) {
    String toUser = profileTo['username'];
    String CurrUserUID = profileFrom['UID'];
    String toUserUID = profileTo['UID'];

    String toUserIcon = profileTo['icon'];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1, vertical: 2),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: kPrimaryColor,
          padding: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Color(0xFFF5F6F9),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatForm(frmUser: CurrUserUID, toUser: toUserUID,toUserUsername: toUser),
            ),
          );
        },
        child: Row(
          children: [
            buildIcon(toUserIcon),
            SizedBox(width: 10),
            buildText(toUser),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }

  Column buildIcon(icon) {
    return Column(
      children: [
        SvgPicture.asset(
          'assets/icons/$icon',
          color: kPrimaryColor,
          width: 40,
        ),
      ],
    );
  }

  Expanded buildText(String UID) {
    return Expanded(
      child: Column(
        children: [
          RichText(
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "$UID \n",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(20),
                    fontWeight: FontWeight.w500,
                    color: kTextColor,
                  ),
                ),
                TextSpan(
                  text: "Hi this is your local supermarket calling to let you know e-ciftci is hereeee!",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(13),
                    fontWeight: FontWeight.w400,
                    color: kTextColor,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

