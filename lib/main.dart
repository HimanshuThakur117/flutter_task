import 'package:flutter/material.dart';
import 'package:flutter_task/screen/auth/Login_Signup_screen.dart';
import 'package:flutter_task/screen/home/HomeScreen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/get_list_bloc/data_bloc.dart';
import 'bloc/get_list_bloc/data_bloc_event.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>  DataBloc()..add(FetchDataEvent(page: 1)),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
       home: LoginScreen(),
      ),
    );
  }
}

