import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vendor/authentication/controllers/login_controller.dart';
import 'package:vendor/authentication/models/user_detail_model.dart';
import 'package:vendor/authentication/views/login_page.dart';
import 'package:vendor/pages/secondpage.dart';
import 'package:vendor/pages/userdetail.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    final userModel = UserModel();


    return Scaffold(


      body:
      // FutureBuilder<Map<String, dynamic>?>(
      //   future: userModel.getUserData(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return CircularProgressIndicator();
      //     } else if (snapshot.hasError) {
      //       return Text('Error retrieving user data');
      //     } else if (snapshot.data == null) {
      //       return LoginScreen2();
      //     } else {
      //       final userData = snapshot.data!;
      //       return Second(userData: userData,);
      //     }
      //   },
      // ),




            FutureBuilder(
              future: LoginController().isLoggedIn(),
              builder: (context, snapshot) {
                print("Data is reload");
                if (snapshot.hasData) {
                  final isLoggedIn = snapshot.data;
                  print("Data get");

                  if (isLoggedIn !=null) {
                    return Second();
                    // return SecondPg();
                  } else {

                    return LoginScreen2();
                  }
                }else {
                  return LoginScreen2();
                  // return Lottie.network('https://assets7.lottiefiles.com/packages/lf20_acmgs9pi.json',width:double.infinity,height:300,fit:BoxFit.cover);
                }


              },
            ),


          
      



    );
  }
}