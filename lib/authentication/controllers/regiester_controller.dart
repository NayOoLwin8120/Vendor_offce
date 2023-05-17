
import 'package:flutter/material.dart';
import 'package:vendor/authentication/models/Loginmodel.dart';
import 'package:vendor/authentication/models/regiester_model.dart';
import 'package:vendor/authentication/views/login_page.dart';
import 'package:vendor/pages/homepage.dart';
// import 'package:vendor/validation/register.dart';


class RegiesterController {
  final RegiesterModel _model = RegiesterModel();

  Future<void> authenticate(
      BuildContext context, String name,String username,String email, String password) async {
    final String? errorMessage = await _model.authenticate(name,username,email, password);
    print(errorMessage);
    if (errorMessage != null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40))),
            title: Text('Regiester Successful.'),
            content: Text('Please Login!'),
          );
        },
      );
      Future.delayed(Duration(seconds: 3), () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginScreen2()
            ), (route) => true);
        // Navigator.pop(context);
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => LoginScreen2()),
        // );
      });
    }
  }
}
