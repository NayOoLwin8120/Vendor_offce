import 'package:flutter/material.dart';
class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  void authenticate() {
    // Set _isAuthenticated to true and notify listeners
    _isAuthenticated = true;
    notifyListeners();
  }

  void signout() {
    // Set _isAuthenticated to false and notify listeners
    _isAuthenticated = false;
    notifyListeners();
  }
}
