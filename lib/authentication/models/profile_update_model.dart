import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfileModel {
  final _baseurl="https://ziizii.mickhae.com/api/vendor";
  final storage=FlutterSecureStorage();
  // final _baseurl="http://192.168.2.105:9999/api/vendor";
  Future<String?> getVendorId() async {
    String? vendorId = await storage.read(key:'id');
    return vendorId;
  }
  Future<String?> authenticate(String name,String username,String email,String phone,String address,String vendor_short_info,String vendor_join,String image ) async {
    try {
      debugPrint("Api Connected");
      String? vendorId = await getVendorId();

      final response = await Dio().post(
        '$_baseurl/profile/update/2',
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
