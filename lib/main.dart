import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_chating_app/Screen/ChatScreen/chat_screen.dart';
import 'package:food_chating_app/Screen/loginScreen/login_screen.dart';
import 'package:food_chating_app/firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return   const MaterialApp(
      debugShowCheckedModeBanner: false,

      home: LoginScreen()
    );
  }
}

