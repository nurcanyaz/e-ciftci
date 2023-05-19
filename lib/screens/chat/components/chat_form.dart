import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../Controllers/ChatController.dart';
import '../../../Controllers/ProfileController.dart';
import '../../../Controllers/UserController.dart';
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
  late Future<String> _currentUserIdFuture;

  @override
  void initState() {
    super.initState();
  }

  Future<String> CurrentUserId() async {
    return (await userController.getCurrentUserId());
  }

  Widget _buildLoadingIndicator() {
    return CircularProgressIndicator();
  }
  @override
  Widget build(BuildContext context) {
    _currentUserIdFuture = CurrentUserId();
    return WillPopScope(
      onWillPop: () async {
        // Perform any necessary cleanup or validation before closing the page
        return true; // Set to false if you want to prevent the page from closing
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.toUserUsername),
        ),
        body: FutureBuilder<String>(
          future: _currentUserIdFuture,
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return _buildLoadingIndicator();
            } else if (userSnapshot.hasError) {
              return Text('Error: ${userSnapshot.error}');
            } else {
              final fromUser = userSnapshot.data;
              if (fromUser == null) {
                return Text('Error: Current user ID is null');
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  StreamBuilder<List<ChatMessage>>(
                stream: chatController.getChatMessages(fromUser, widget.toUser), // Function to fetch chat messages
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return _buildLoadingIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        final chatMessages = snapshot.data ?? [];
                        List<ChatMessage> reversedChatMessages = List.from(chatMessages.reversed);
                        return Expanded(
                          child: ListView.builder(

                            itemCount: 1,
                            itemBuilder: (context, index) {

                              return ChatMessagesWidget(
                                widget.toUser,
                                fromUser!,
                                buildChatBubbleTo,
                                buildChatBubbleCurrentUser, reversedChatMessages
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                  buildMessageField(),
                ],
              );
            }
          },
        ),
      ),
    );
  }
  Container buildChatBubbleTo(String msg, DateTime date) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.fromLTRB(20, 5, 5, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
            style: TextButton.styleFrom(
              primary: kPrimaryColor,
              padding: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              backgroundColor: Color(0xFFF5F6F9),
            ),
            onPressed: () {},
            child: Text(
              msg,
              style: TextStyle(
                fontSize: getProportionateScreenWidth(27),
                fontWeight: FontWeight.w400,
                color: kTextColor,
              ),
            ),
          ),
          SizedBox(height: 4),
          Text(
            date.toString(),
            style: TextStyle(
              fontSize: getProportionateScreenWidth(12),
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Container buildChatBubbleCurrentUser(String msg, DateTime date) {
    return Container(
      alignment: Alignment.centerRight,
      margin: EdgeInsets.fromLTRB(20, 5, 20, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextButton(
            style: TextButton.styleFrom(
              primary: kPrimaryColor,
              padding: EdgeInsets.all(15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              backgroundColor: kPrimaryColor,
            ),
            onPressed: () {},
            child: Text(
              msg,
              style: TextStyle(
                fontSize: getProportionateScreenWidth(25),
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 4),
          Text(
            date.toString(),
            style: TextStyle(
              fontSize: getProportionateScreenWidth(10),
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }




  Widget buildMessageField() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(10),
          vertical: getProportionateScreenHeight(10)),
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
                    prefixIcon: Icon(
                      Icons.chat_bubble_outline,
                      color: kPrimaryColor,
                    ),
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
                    id: messageId,
                    // Assign a unique ID to the message
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

class ChatMessagesWidget extends StatelessWidget {
  final String toUser;
  final String fromUser;
  final List<ChatMessage> messages;
  final Container Function(String,DateTime) buildChatBubbleCurrentUser;
  final Container Function(String,DateTime) buildChatBubbleTo;
  final ChatController chatController = ChatController();

  ChatMessagesWidget(this.toUser, this.fromUser,
      this.buildChatBubbleTo, this.buildChatBubbleCurrentUser, this.messages);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: messages.map((message) {
        if (message.senderId == toUser) {
          return buildChatBubbleTo(message.message,message.timestamp);
        } else if (message.senderId == fromUser) {
          return buildChatBubbleCurrentUser(message.message,message.timestamp);
        }
        else {
          return SizedBox.shrink();
        }
      }).toList(),
    );
  }
}