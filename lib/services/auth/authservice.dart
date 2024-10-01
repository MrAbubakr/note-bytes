import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authservice extends ChangeNotifier{
  final FirebaseAuth  _firebaseAuth = FirebaseAuth.instance; 
  // sign in with email and password
  Future<UserCredential> signInwithEmailandPassword(String email, String password) async{
    try{
       UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, 
        password: password);
        return userCredential;
    } 
    on FirebaseAuthException catch(e){
      throw Exception(e.code);
    }
  }
  // signout
  Future<void> signOut() async{
    return await FirebaseAuth.instance.signOut();

  }
  // register
  Future<UserCredential>signUpwithEmailandPassword(String email, Password) async{
    try{
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: Password);
      return userCredential;
    } on FirebaseAuthException catch (e){
      throw Exception(e.code);
    }

  }

  
}