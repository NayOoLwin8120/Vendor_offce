import 'package:dio/dio.dart';
import 'package:vendor/Model/regiestermodel.dart';

class RegistrationController {
  final String _baseUrl = 'https://your-api-url.com';
  final Dio _dio = Dio();
  final UserRegiester _user;

  RegistrationController({UserRegiester? user})
      : _user = user ?? UserRegiester(name: '', username: '', email: '', password: '');

  Future<bool> registerUser() async {
    try {
      Response response = await _dio.post(
        '$_baseUrl/register',
        data: {
          'name': _user.name,
          'username': _user.username,
          'email': _user.email,
          'password': _user.password,
        },
      );
      if (response.statusCode == 200) {
        _user.token = response.data['token'];
        _user.saveToken(_user.token);
        return true;
      }
      return false;
    } catch (error) {
      print(error);
      return false;
    }
  }
}