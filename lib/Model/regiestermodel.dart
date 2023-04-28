import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserRegiester {
  String name;
  String username;
  String email;
  String password;
  String token;

  UserRegiester({required this.name, required this.username, required this.email, required this.password, this.token = ''});

  void saveToken(String token) async {
    final storage = new FlutterSecureStorage();
    await storage.write(key: 'token', value: token);
  }
}