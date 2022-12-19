// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ij_chat_app/shared/styls/colors.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../shared/components/components.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();
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
                      height: 150,
                      width: 150,
                    ),
                    Text(
                      "IJ Chat",
                      style: TextStyle(
                          fontSize: 30,
                          color: defColor,
                          fontFamily: 'Pacifico'),
                    ),
                    SizedBox(
                      height: 40,
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
                      prefixIcon: Icons.lock_outline,
                    ),
                    Row(
                      children: [
                        Spacer(),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, 'ForgetPasswordScreen');
                            },
                            child: Text('Forget Password ?')),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                        function: () {
                          if (formKey.currentState!.validate()) {
                            isLoading = true;
                            setState(() {});
                            try {
                              loginUser();
                              showMySnackBar(context, "Sign-in successful.");
                              Navigator.pushNamed(context, "ChatPage",
                                  arguments: myemail);

                              print("Sign-in successful.");
                            } on FirebaseAuthException catch (e) {
                              switch (e.code) {
                                case "user not found":
                                  showMySnackBar(context, "user not found");
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
                        text: "Login",
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
                            child: Text('Don\'t Have Account ?')),
                        // SizedBox(
                        //   width: 1,
                        // ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'RegisterScreen');
                            },
                            child: Text('Sign Up')),
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

  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: myemail, password: mypassword);
  }
}
