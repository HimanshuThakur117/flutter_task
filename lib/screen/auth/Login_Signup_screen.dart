import 'package:flutter/material.dart';
import 'package:flutter_task/utils/assets.dart';
import 'package:flutter_task/screen/auth_services.dart';
import 'package:google_sign_in/google_sign_in.dart';



GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      "email",
      "https://www.googleapis.com/auth/contacts.readonly"
    ]
);


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   GoogleSignInAccount ?currentUser;
   GoogleServices googleServices =  GoogleServices();

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((account) {

      setState(() {
       currentUser = account!;
      });
      if(currentUser!=null){
        print("user is already authenticate");
      }

    });

    _googleSignIn.signInSilently();

  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body:  Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(Assets.welcomeImg))
              ),
            ),

            const  SizedBox(
              height: 100,
            ),

            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Assets.googleImg))
              ),
            ),

            const  Text(
              'What You waiting for! Just login',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const   SizedBox(
              height: 200,
            ),

            GestureDetector(
              onTap: (){
                googleServices.handleSignIn(context);
              },
              child:  Container(
                height: 50,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20,0,20,0),
                  child: Row(
                    children: [
                      Image.asset(Assets.googleImg),

                      Text(" Click here to Login",style: TextStyle(
                          fontSize: 20,fontWeight: FontWeight.bold
                      ),),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
