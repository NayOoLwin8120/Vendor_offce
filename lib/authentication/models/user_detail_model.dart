import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserModel {
  final _storage = FlutterSecureStorage();
  final _baseurl="https://ziizii.mickhae.com/api/vendor";
  // final _baseurl="http://192.168.2.105:9999/api/vendor";

  Future<Map<String, dynamic>?> getUserData() async {
    try {
      final token = await _storage.read(key: 'token');
      final vendorid=await _storage.read(key: 'id');
      if (token == null) {
        return null; // User is not logged in
      }

      final response = await Dio().get(
        '$_baseurl/detail/$vendorid',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['image'] != null) {
          final imageUrl = responseData['image']['url'];
          return {...responseData, 'imageUrl': imageUrl};
        }else{
          return responseData;
        }


      } else {
        return null; // Error retrieving user data
      }
    } catch (error) {


      return null; // Error connecting to API
    }
  }

  Future<String?> authenticate(String email, String password) async {
    try {
      final response = await Dio().post(
        '$_baseurl/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.data);
        final token = responseData['auth_token'];
        await _storage.write(key: 'token', value: token);
        await _storage.write(key: 'username', value: email);
        await _storage.write(key: 'password', value: password);

        return null;
      } else {
        final errorMessage = response.data['message'];
        return errorMessage.toString();
      }
    } catch (error) {
      debugPrint("API connection failed");
      return error.toString();
    }
  }


}
