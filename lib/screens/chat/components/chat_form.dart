import 'package:e_ciftcim/components/custom_surfix_icon.dart';
import 'package:e_ciftcim/components/form_error.dart';
import 'package:e_ciftcim/helper/keyboard.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:e_ciftcim/models/User.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';
import '../../../Controllers/ChatController.dart';
import '../../../Controllers/ProfileController.dart';
import '../../../Controllers/UserController.dart';
import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../models/ChatMessages.dart';
import '../../../models/Profile.dart';
import '../../../size_config.dart';
class ChatForm extends StatefulWidget {
  final String frmUser;
  final String toUser;
  final String toUserUsername;

  ChatForm({
    Key? key,
    required this.frmUser,
    required this.toUser,
    required this.toUserUsername,
  }) : super(key: key);

  @override
  _ChatFormState createState() => _ChatFormState();
}

class _ChatFormState extends State<ChatForm> {
  final _formKey = GlobalKey<FormState>();
  late String msgSend;
  late String receiver = widget.toUser;
  final ChatController chatController = ChatController();
  final UserProfileController profileController = UserProfileController();
  final UserController userController = UserController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.toUserUsername),
      ),
      body: StreamBuilder<List<Profile>>(
        stream: profileController.getProfileStream(),
        builder: (BuildContext context, AsyncSnapshot<List<Profile>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
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
                            return Text('Er3ror: ${userSnapshot.error}');
                          } else {
                            final fromUser = userSnapshot.data;
                            if (fromUser != null) {
                              return StreamBuilder<List<ChatMessage>>(
                                stream: chatController.getChatMessages(toUser.uid, fromUser),
                                builder: (context, chatSnapshot) {
                                  if (chatSnapshot.connectionState == ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else if (chatSnapshot.hasError) {
                                    return Text('Er7ror: ${chatSnapshot.error}');
                                  } else {
                                    List<ChatMessage> messages = chatSnapshot.data ?? [];
                                    return ListView.builder(
                                      reverse: true,
                                      itemCount: messages.length,
                                      itemBuilder: (context, index) {
                                        ChatMessage message = messages[index];
                                        if (message.senderId == toUser.uid) {
                                          return buildChatBubbleTo(message.message);
                                        } else {
                                          return buildChatBubbleCurrentUser(message.message);
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
                ),
                buildMessageField(),
              ],
            );
          }
        },
      ),
    );
  }

  Padding buildChatBubbleTo(String msg) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22, vertical: 0),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: kPrimaryColor,
          padding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          backgroundColor: Color(0xFFF5F6F9),
        ),
        onPressed: () {},
        child: Row(
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "${widget.toUser}\n",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(20),
                        fontWeight: FontWeight.w500,
                        color: kTextColor,
                      ),
                    ),
                    TextSpan(
                      text: msg,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(13),
                        fontWeight: FontWeight.w400,
                        color: kTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildChatBubbleCurrentUser(String msg) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22, vertical: 0),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: kPrimaryColor,
          padding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          backgroundColor: Color(0xFFF5F6F9),
        ),
        onPressed: () {},
        child: Row(
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "${widget.toUser}\n",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(20),
                        fontWeight: FontWeight.w500,
                        color: kTextColor,
                      ),
                    ),
                    TextSpan(
                      text: msg,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(13),
                        fontWeight: FontWeight.w400,
                        color: kTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMessageField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10), vertical: getProportionateScreenHeight(10)),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: kSecondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  onSaved: (value) => msgSend = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return kMessageNullError;
                    }
                    return null; // No error
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                      vertical: getProportionateScreenWidth(9),
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: "Mesaj",
                    prefixIcon: Icon(Icons.chat_bubble_outline,
                      color: kPrimaryColor,),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: SizeConfig.screenWidth * 0.012),
          Container(
            width: SizeConfig.screenWidth * 0.15,
            decoration: BoxDecoration(
              color: kSecondaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: IconButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  var uuid = Uuid();

                  // Generate a random ID
                  String messageId = uuid.v4();
                  ChatMessage chatMessage = ChatMessage(
                    id: messageId, // Assign a unique ID to the message
                    senderId: widget.frmUser,
                    receiverId: receiver,
                    message: msgSend,
                    timestamp: DateTime.now(),
                  );
                  await chatController.saveMessage(chatMessage);
                  _formKey.currentState!.reset();
                }
              },
              icon: Icon(Icons.send),
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
