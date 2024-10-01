import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_byte/services/auth/login_or_register.dart';
import 'package:notes_byte/services/home.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),
       builder: (context, snapshot){
        if(snapshot.hasData){
          return const HomeScreen();
        } else {
          return const LoginOrRegisterscreen();
        }
       }),
    );
  }
}