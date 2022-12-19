// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ij_chat_app/pages/models/message_model.dart';
import 'package:ij_chat_app/shared/styls/colors.dart';

import '../../shared/components/chat_bubble.dart';
import '../../shared/constants.dart';

class ChatPage extends StatelessWidget {
  static String id = "ChatPage";

  final _controller = ScrollController();

  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: messages
            .orderBy(
              'createAt',
            )
            .snapshots(),
        builder: (context, snapshot) {
          // print(snapshot.data!['message']);
          if (snapshot.hasData) {
            List<MessageModel> messagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(MessageModel.fromJson(snapshot.data!.docs[i]));
            }
            // print(snapshot.data!.docs[0]['message']);
            return Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  title: Center(
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_back,
                          size: 30,
                        ),
                        CircleAvatar(
                          backgroundImage: AssetImage(user),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          " Islam Jamal",
                          style: TextStyle(
                              fontFamily: 'Pacifico',
                              fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Icon(
                          Icons.videocam,
                          size: 25,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.call,
                          size: 25,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.more_vert_outlined,
                          size: 25,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                  centerTitle: true,
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          controller: _controller,
                          itemCount: messagesList.length,
                          itemBuilder: (context, index) {
                            return messagesList[index].id == email
                                ? ChatBubble(
                                    messageModel: messagesList[index],
                                  )
                                : ChatBubbleResponse(
                                    messageModel: messagesList[index],
                                  );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        controller: messageController,
                        onSubmitted: (data) {
                          messages.add({
                            'message': data,
                            'createAt': DateTime.now(),
                            'id': email,
                          });
                          messageController.clear();
                          _controller.animateTo(
                              _controller.position.maxScrollExtent,
                              duration: Duration(milliseconds: 900),
                              curve: Curves.fastOutSlowIn);
                        },
                        decoration: InputDecoration(
                          hintText: 'Send Message ...',
                          suffixIcon: Icon(Icons.send),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: defColor)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: defColor)),
                        ),
                      ),
                    )
                  ],
                ));
          } else {
            return Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: defColor,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Dialog(
                        child: Text(
                      "Loading...",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    )),
                  ],
                ));
          }
        });
  }
}
