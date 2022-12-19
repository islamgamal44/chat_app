// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ij_chat_app/pages/models/message_model.dart';

import '../styls/colors.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({Key? key, required this.messageModel}) : super(key: key);

  final MessageModel messageModel;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        // alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 25, top: 15, bottom: 15, right: 25),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            color: defColor),
        child: Text(
          messageModel.message,
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
    );
  }
}

class ChatBubbleResponse extends StatelessWidget {
  const ChatBubbleResponse({Key? key, required this.messageModel})
      : super(key: key);

  final MessageModel messageModel;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        // alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 25, top: 15, bottom: 15, right: 25),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            color: Colors.grey.shade700),
        child: Text(
          messageModel.message,
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
    );
  }
}
