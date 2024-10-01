
import 'package:flutter/material.dart';
import 'package:notes_byte/appconstant.dart';
import 'package:notes_byte/common/custombutton.dart';
import 'package:notes_byte/common/customtextfield.dart';
import 'package:notes_byte/services/auth/authservice.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  final void Function()? onTap;
  const LoginScreen({super.key, required this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
    TextEditingController emailcontroller = TextEditingController();
      TextEditingController passwordcontroller = TextEditingController();
     void signIn() async{
      final authService = Provider.of<Authservice>(context, listen: false);
      try{
      await  authService.signInwithEmailandPassword( emailcontroller.text.trim(), 
      passwordcontroller.text.trim());
      } catch(e){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()))
        );
      }
     }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.Background,
      appBar: null,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(children: [
              const SizedBox(height: 80,),
              Image.asset("assets/images/final img.png", height: 160, ),
              const SizedBox(height: 20,),
              const  Text("Welcom To Back", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,
                 color: AppConstant.textbutton),),
               const SizedBox(height: 30,),
               CustomTextField(controller: emailcontroller, hintText: 'Email', obscureText: false),
               const SizedBox(height: 20,),
               CustomTextField(controller: passwordcontroller, hintText: "Password", obscureText: true),
               const SizedBox(height: 20,),
               CustomButton(title: "Login", onTap: signIn),
               const SizedBox(height: 50,),
        
               Row( mainAxisAlignment: MainAxisAlignment.center,
              children: [ 
              const Text("Not a member ?  ",
              style: TextStyle(fontWeight: FontWeight.bold ),), 
              GestureDetector(
              onTap: widget.onTap,
              child: Text("Register Now", style: TextStyle(fontWeight: FontWeight.bold,
               color: AppConstant.textbutton),),
            )
            ],),
              
            ],),
          ),
        ),
      ),
    );
  }
}