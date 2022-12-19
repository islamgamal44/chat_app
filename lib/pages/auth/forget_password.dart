// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:ij_chat_app/shared/styls/colors.dart';

import '../../shared/components/components.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var forgetPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50, bottom: 30),
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    height: 150,
                    width: 150,
                  ),
                  Text(
                    "IJ Chat",
                    style: TextStyle(
                        fontSize: 30, color: defColor, fontFamily: 'Pacifico'),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  defaultFormField(
                      controller: forgetPassword,
                      type: TextInputType.emailAddress,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please Re entre your email ';
                        } else {
                          return null;
                        }
                      },
                      label: 'email',
                      prefixIcon: Icons.email_outlined),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                      function: () {}, text: "Check", radius: 12, width: 200),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
