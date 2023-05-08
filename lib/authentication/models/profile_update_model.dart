import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ProfileModel {
  Future<String?> authenticate(String name,String username,String email,String phone,String address,String vendor_short_info,String vendor_join,String image ) async {
    try {
      debugPrint("Api Connected");

      final response = await Dio().post(
        'http://192.168.2.106:9999/api/vendor/profile/update/2',
        data: {
          'name':name,
          'username':username,
          'email': email,
          'phone':phone,
          'address':address,
          'vendor_join':vendor_join,
          'vendor_short_info':vendor_short_info,
          'photo':image,

        },
        // data:formData,
      );

      if (response.statusCode == 200) {
        try{
          print("Step 1");
          final responseData = response.data;
          print(responseData);
          final data=responseData['message'];
         print(data.toString());

        }catch(e){
          return e.toString();
        }



        return null;
      } else {
        debugPrint(response.statusCode.toString());
        final errorMessage = response.data['error'];
        return errorMessage.toString();
      }
    } catch (error) {
      debugPrint("Api is not connected");
      return error.toString();
    }
  }
}
