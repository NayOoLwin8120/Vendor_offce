import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RegiesterModel {
  final _storage = FlutterSecureStorage();

  Future<String?> authenticate(String name,String username,String email, String password) async {
    try {

      final response = await Dio().post(
        'http://192.168.2.111:9999/api/vendor/register',
        data: {
          'name':name,
          'username':username,
          'email': email,
          'password': password,
        },
      );
      debugPrint("Api Connected");
      if (response.statusCode == 201) {
        final responseData = response.data;
        final token = responseData['token'];

        await _storage.write(key: 'token', value: token);
        await _storage.write(key: 'username', value: email);
        await _storage.write(key: 'password', value: password);

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
