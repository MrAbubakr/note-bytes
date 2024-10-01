import 'package:flutter/material.dart';
import 'package:notes_byte/appconstant.dart';
import 'package:notes_byte/services/auth/auth_gate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
   void initState(){
    super.initState();
    Future.delayed( const Duration(seconds: 3), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const AuthGate()));
    }
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(appBar: null,
    backgroundColor: AppConstant.Background,
    body: Center(
      child: Stack(
        children: [
          Image.asset("assets/images/final img.png", ),

        ],
      ),
    ),
    );
  }
}