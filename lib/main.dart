import 'package:flutter/material.dart';
import 'package:vendor/pages/homepage.dart';
import 'package:vendor/validatiion/login.dart';
import 'package:vendor/validatiion/login_page1.dart';
import 'package:vendor/authentication/views/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      // home: LoginScreen(),
      // home:LoginScreen2() ,
      home:MyHomePage(title: "Home",),
    );
  }
}


