import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vendor/pages/homepage.dart';

class Userdetail extends StatefulWidget {
  // final Map<String, dynamic> userData;
  // const Userdetail({Key? key,required this.userData}) : super(key: key);
  const Userdetail({Key? key}) : super(key: key);

  @override
  State<Userdetail> createState() => _UserdetailState();
}

class _UserdetailState extends State<Userdetail> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text("User Profile"),
      ),
      body:
      // debugPrint("${widget.userData['data']['photo']}"),
      Center(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //tomorrow change
        // Text('Welcome - ${widget.userData['data']['username']}'),
        // Text('Hello  ${widget.userData['data']['name']}'),
        // Text('Phonenumber -${widget.userData['data']['phone']}'),
        // Text('Your email address - ${widget.userData['data']['email']}.'),
        // // Text('Your user photo - ${widget.userData['data']['id']}.'),
        //
        // // Image.network(" ${widget.userData['data']['photo']}"),
        // Image.network("http://192.168.2.111:9999/upload/vendor_images/up-vendor/2023/d5d8cffc-f699-4daa-ab14-b936b96d9c06.jpeg"),
        // Text('Your user ID - ${widget.userData['data']['id']}.'),
        // Text('Your user ID - ${widget.userData['data']['id']}.'),
        // Text('Your user ID - ${widget.userData['data']['id']}.'),
        // Text('Your user ID - ${widget.userData['data']['id']}.'),
        // Text('Your user ID - ${widget.userData['data']['id']}.'),
        // Text('Your user ID - ${widget.userData['data']['id']}.'),
        // Text('Your user ID - ${widget.userData['data']['id']}.'),
        Container(

        )
      ],
    ),
    ),

    );
  }
}
