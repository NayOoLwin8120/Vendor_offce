import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vendor/authentication/controllers/login_controller.dart';
import 'package:vendor/authentication/models/user_detail_model.dart';

import 'package:vendor/pages/userdetail.dart';
import 'package:vendor/authentication/views/userdetail2.dart';

class Second extends StatefulWidget {


  const Second({Key? key}) : super(key: key);

  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {
  final userModel = UserModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_alert),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          ),
          TextButton(
            child:Text("Logout",style:TextStyle(color:Colors.white) ,),

            onPressed: () {
              LoginController().logout(context);
            },
          ),

        ],
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(

                builder: (context) {
                  return FutureBuilder<Map<String, dynamic>?>(
                    future:userModel.getUserData() ,
                    builder: (context,  snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Lottie.network("https://assets6.lottiefiles.com/private_files/lf30_jo7huq2d.json");
                      }
                      else if (snapshot.connectionState == ConnectionState.done) {
                        final userData = snapshot.data!;
                        return UserDetailScreen(userData: userData) ;
                        // return Userdetail() ;
                      }
                      else if (snapshot.hasError){
                        return Lottie.network('https://assets9.lottiefiles.com/packages/lf20_0hj4Khn1at.json');
                    } else{
                        return Text("No found");
                      }
                    },
                  );
                },
                // builder:(context)=>UserDetailScreen(),
              ),
            );
          },
          child: ElevatedButton(
            onPressed: null,
            child: Text('Show Vendor Deatails'),
          ),
        ),

      ),

    );
  }
}
