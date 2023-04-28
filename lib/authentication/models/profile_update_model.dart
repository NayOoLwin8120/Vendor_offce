import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ProfileModel {
  Future<String?> authenticate(String name,String username,String email,String phone,String address,String vendor_short_info,String photo ) async {
    try {
      debugPrint("Api Connected");
      final response = await Dio().post(
        'http://192.168.2.111:9999/api/vendor/profile/update/2',
        data: {
          'name':name,
          'username':username,
          'email': email,
          'photo':photo,
          'phone':phone,
          'address':address,
          'vendor_short_info':vendor_short_info,

        },
      );

      if (response.statusCode == 200) {
        try{
          print("Step 1");
          final responseData = response.data;
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
