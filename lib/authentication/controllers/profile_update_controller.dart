
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vendor/authentication/models/profile_update_model.dart';
import 'package:vendor/pages/secondpage.dart';



class ProfileController {
  final ProfileModel _model = ProfileModel();


  Future<void> authenticate( BuildContext context,String name, String username, String email,
     String phone, String address, String vendor_short_info,
      String vendor_join, String image) async {

    final String? errorMessage = await _model.authenticate(name,username,email,phone,address,vendor_short_info,vendor_join,image) ;
    if (errorMessage == null) {
      print(errorMessage);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text("please Try Again !"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      print("No Error");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40))),
            title: Text('Profile Updated Successful'),

          );
        },
      );
      Future.delayed(Duration(seconds: 3), () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Second()
            ), (route) => false);
        // Navigator.pop(context);
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => Second()),
        // );
      });
    }
  }

}
