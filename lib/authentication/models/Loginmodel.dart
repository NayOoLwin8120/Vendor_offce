import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginModel {
  final _storage = FlutterSecureStorage();
  final _baseurl="https://ziizii.mickhae.com/api/vendor";
  // final _baseurl="http://192.168.2.105:9999/api/vendor";

  Future<String?> authenticate(String email, String password) async {
    try {
      debugPrint("Api Connected");
      final response = await Dio().post(
        '$_baseurl/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        try{
          print("Step 1");
          final responseData = response.data;
          // final resdata=jsonDecode(responseData);

          // print(responseData['message']);
          // final responseData = jsonDecode(response.data);
          // final token = responseData['auth_token'];

          final token = responseData['data']['auth_token'];
          final vendorid=responseData['data']['id'].toString();
          final vendorstatus=responseData['data']['status'];
          print(token);
          print(vendorstatus);
          print(vendorid);
          print(vendorid.toString());
          // print(vendorstatus);
          
          await _storage.write(key: 'vendor_status', value: vendorstatus);
          await _storage.write(key: 'id', value: vendorid);
          await _storage.write(key: 'token', value: token);
          await _storage.write(key: 'username', value: email);
          await _storage.write(key: 'password', value: password);

        }catch(e){
          return e.toString();
        }
        return null;
      } else {
        debugPrint(response.statusCode.toString());
        final errorMessage = response.data['message'];
        print(errorMessage);
        return errorMessage.toString();
      }
    } catch (error) {
      debugPrint("Api is not connected");
      return error.toString();
    }
  }
}
