
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:vendor/authentication/models/Loginmodel.dart';
import 'package:vendor/pages/homepage.dart';
import 'package:vendor/pages/secondpage.dart';
import 'package:vendor/validatiion/login_page1.dart';
// import 'package:vendor/validation/register.dart';


class LoginController {
  final LoginModel _model = LoginModel();
  final _storage = FlutterSecureStorage();

  Future<void> authenticate(
      BuildContext context, String email, String password) async {
    final String? errorMessage = await _model.authenticate(email, password);

    if (errorMessage != null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text("please Try Again !"),
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
            title: Text('Login successful'),
            content: Text('Welcome to MultiOnline Shop'),
          );
        },
      );
      Future.delayed(Duration(seconds: 3), () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Second()
            ), (route) => false);
        // Navigator.pop(context);
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => Second()),
        // );
      });
    }
  }
  Future<String?> isLoggedIn() async {
    final token=await _storage.read(key: 'token');
    final vendor_id=await _storage.read(key: 'id');
    final runtime_type=vendor_id.runtimeType;
    final status=await _storage.read(key: 'vendor_status');

    debugPrint("Your vendor id  is $vendor_id");
    debugPrint("Your vendor status  is $status");
    debugPrint("Your vendor status  is ${status.runtimeType}");
    debugPrint("--------- Your vendor id runtime type is $runtime_type ---------");

    debugPrint("--------- Your auth token  is `$token` ---------");
    // tomorrow night change
    return await _storage.read(key: 'token');
 // return "abc";


  }
   logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you Sure To Logout!'),

        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async{
              await _storage.delete(key: 'id');
              await _storage.delete(key: 'vendor_status');
              await _storage.delete(key: 'token');
              await _storage.delete(key: 'username');
              await _storage.delete(key: 'password');
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage(title:"Home")),
              );
              print("Hello");
            },
            child: Text('Ok'),
          ),

        ],
      ),
    );
    // await _storage.delete(key: 'token');
    // await _storage.delete(key: 'username');
    // await _storage.delete(key: 'password');
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => MyHomePage(title:"Home")),
    // );
  }


}
