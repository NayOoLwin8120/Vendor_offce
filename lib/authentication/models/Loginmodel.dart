import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginModel {
  final _storage = FlutterSecureStorage();

  Future<String?> authenticate(String email, String password) async {
    try {
      debugPrint("Api Connected");
      final response = await Dio().post(
        'http://192.168.2.111:9999/api/vendor/login',
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

          final token = responseData['data']['auth_token'];
          print(token);
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
        return errorMessage.toString();
      }
    } catch (error) {
      debugPrint("Api is not connected");
      return error.toString();
    }
  }
}
