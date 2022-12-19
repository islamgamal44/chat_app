// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ij_chat_app/shared/styls/colors.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../shared/components/components.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var formKey = GlobalKey<FormState>();

  var usernameController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var phoneController = TextEditingController();

  var myemail, mypassword;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
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
                      height: 100,
                      width: 100,
                    ),
                    Text(
                      "IJ Chat",
                      style: TextStyle(
                          fontSize: 25,
                          color: defColor,
                          fontFamily: 'Pacifico'),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    defaultFormField(
                        controller: usernameController,
                        type: TextInputType.name,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please entre your user name';
                          } else {
                            return null;
                          }
                        },
                        label: 'user name',
                        prefixIcon: Icons.person_outline),
                    SizedBox(
                      height: 10,
                    ),
                    defaultFormField(
                        onChange: (data) {
                          myemail = data;
                        },
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please entre your email ';
                          } else {
                            return null;
                          }
                        },
                        label: 'email',
                        prefixIcon: Icons.email_outlined),
                    SizedBox(
                      height: 10,
                    ),
                    defaultFormField(
                        onChange: (data) {
                          mypassword = data;
                        },
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please entre your password';
                          } else {
                            return null;
                          }
                        },
                        label: 'Password',
                        prefixIcon: Icons.visibility_outlined),
                    SizedBox(
                      height: 10,
                    ),
                    defaultFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please entre your phone number';
                          } else {
                            return null;
                          }
                        },
                        label: 'phone number',
                        prefixIcon: Icons.phone_outlined),
                    SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                        function: () {
                          if (formKey.currentState!.validate()) {
                            isLoading = true;
                            setState(() {});
                            try {
                              registerUser();
                              showMySnackBar(context, "Sign-up successful.");
                              Navigator.pushNamed(context, "ChatPage",
                                  arguments: myemail);

                              print("Sign-up successful.");
                            } on FirebaseAuthException catch (e) {
                              switch (e.code) {
                                case "email is already in-use":
                                  showMySnackBar(
                                      context, "email is already in-use");
                                  break;
                                case "wrong password":
                                  showMySnackBar(
                                      context, "The Password is wrong.");

                                  break;
                                default:
                                  showMySnackBar(
                                      context, "there was an error.");
                              }
                            }
                            isLoading = false;
                            setState(() {});
                          } else {}
                        },
                        text: "Sign Up",
                        radius: 12,
                        width: 200),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: Text('Already Have An Account ?')),
                        // SizedBox(
                        //   width: 70,
                        // ),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Sign In')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showSnackBar(BuildContext context, Object e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e.toString()),
      ),
    );
  }

  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: myemail, password: mypassword);
  }
}
