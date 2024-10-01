
import 'package:flutter/material.dart';
import 'package:notes_byte/appconstant.dart';
import 'package:notes_byte/common/custombutton.dart';
import 'package:notes_byte/common/customtextfield.dart';
import 'package:notes_byte/services/auth/authservice.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  final void Function()? onTap;
  const RegisterScreen({super.key, required this.onTap});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  
    TextEditingController emailcontroller = TextEditingController();
      TextEditingController passwordcontroller = TextEditingController();
      TextEditingController confirmpasswordcontroller = TextEditingController();
      void signUp() async{
        if(passwordcontroller.text != confirmpasswordcontroller.text){
          ScaffoldMessenger.of(context).showSnackBar(
           const SnackBar(content: Text("passwords don't match")),
          );
          return;
        }
        // sighUp 
      final  authservice = Provider.of<Authservice>(context, listen: false);
      try{
        await authservice.signUpwithEmailandPassword(
          emailcontroller.text.trim(),
         passwordcontroller.text.trim());
      }  catch(e){
        ScaffoldMessenger(child: Text(e.toString()));
      }
      }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        
        backgroundColor: AppConstant.Background,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column( 
                children: [ 
                 const SizedBox(height: 80,),
                   //welcom back mesage 
                Image.asset("assets/images/final img.png", height: 160, ),
                   const SizedBox(height: 20,),
                const  Text("Welcom To Note_Here", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,
                   color: AppConstant.textbutton),),
              
              //email textfield
              const SizedBox(height: 20,),
              CustomTextField(controller: emailcontroller, hintText: "Enter Your Email", obscureText: false),
              //password textfield
              const SizedBox(height: 20,),
              CustomTextField(controller: passwordcontroller, hintText: "Enter Your Password", obscureText: true),
              const SizedBox(height: 20,),
              CustomTextField(controller: confirmpasswordcontroller, hintText: "Again Enter Password", obscureText: true),
              
              //button
              const SizedBox(height: 20,),
              CustomButton(title: "SignUp", onTap: signUp),
              //register now
              const SizedBox(height: 25,),
              Row( mainAxisAlignment: MainAxisAlignment.center,
                children: [ 
                const Text("Already a member ?  ",
                style: TextStyle(fontWeight: FontWeight.bold ),), 
                GestureDetector(
                onTap: widget.onTap,
                child: const Text("Login ", style: TextStyle(fontWeight: FontWeight.bold,
                 color: AppConstant.textbutton),),
              )
              ],),
              
                ],
              
              ),
            ),
          ),
        ),
      ),
    );
  }
}