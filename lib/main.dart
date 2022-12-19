// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ij_chat_app/pages/auth/forget_password.dart';
import 'package:ij_chat_app/pages/auth/login.dart';
import 'package:ij_chat_app/pages/auth/sign_up.dart';
import 'package:ij_chat_app/pages/chat/chat_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

      // options: FirebaseOptions(
      //   apiKey:
      //       "AAAAVQiZhJg:APA91bFHzaM_oQGfqPMQybSgjlf4WvS61oRnDIlBDybe-puSreF-uNPnCd0yb4dBgkZpaBswdFhHAOfxWXSdYhR8QoqSfNVwe7l7-ELInR4pSVQtDj1Ja5vrLVhpa2H-MD7KMiwN_xei",
      //   messagingSenderId: "365216498840",
      //   projectId: "chat-app-8dc6e",
      //   appId: '1:365216498840:android:5a6dc1068aecb5f4737ced',
      // ),
      );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'LoginScreen': (context) => LoginScreen(),
        'RegisterScreen': (context) => SignUpScreen(),
        'ForgetPasswordScreen': (context) => ForgetPasswordScreen(),
        'ChatPage': (context) => ChatPage(),
      },
      theme: ThemeData(
        primaryColor: Colors.teal,
        primarySwatch: Colors.teal,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: 'LoginScreen',
    );
  }
}
