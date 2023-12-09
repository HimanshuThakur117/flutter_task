import 'package:flutter/material.dart';
import 'package:flutter_task/screen/auth/Login_Signup_screen.dart';
import 'package:flutter_task/screen/home/HomeScreen.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleServices {


  final GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: <String>[
        "email",
        "https://www.googleapis.com/auth/contacts.readonly"
      ]
  );


  Future<void> handleSignIn(context) async{
    try{
      await _googleSignIn.signIn();
    }catch(e){
      print("error in sigin"+e.toString());
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>  HomeScreen()),
    );
  }

  Future<void> handleSignOut(context) async{
    await _googleSignIn.disconnect();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  LoginScreen()),
    );
  }


}