
import 'package:flutter/material.dart';
import 'package:notes_byte/services/login.dart';
import 'package:notes_byte/services/register.dart';

class LoginOrRegisterscreen extends StatefulWidget {
  const LoginOrRegisterscreen({super.key});

  @override
  State<LoginOrRegisterscreen> createState() => _LoginOrRegisterscreenState();
}

class _LoginOrRegisterscreenState extends State<LoginOrRegisterscreen> {
 // initially show login screen
 bool showLoginScreen = true;
 // toggle b\t login and register
@override
  void toggleScreens(){
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showLoginScreen){
      return LoginScreen(onTap: toggleScreens);
    } else {
      return  RegisterScreen(onTap: toggleScreens);
  }
    }
}