
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:vendor/validatiion/login.dart';


class SignupPage extends StatefulWidget {
  SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _key = GlobalKey<FormState>();
  final _storage = FlutterSecureStorage();
  bool _obscureText = true;
  bool _obscureText2 = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  // TextEditingController confirmpasswordController = TextEditingController();

  TextEditingController usernamecontroller = TextEditingController();

  bool _isRegistering = false;
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;

    });
  }
  void _toggleObscureText2() {
    setState(() {
      _obscureText2 = !_obscureText2;

    });
  }

  Future<void> _register() async {

    if (_key.currentState!.validate()) {
      setState(() {
        _isRegistering = true;
      });


      final username = usernamecontroller.text.trim();
      final name = nameController.text.trim();
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      // final confirmpassword = confirmpasswordController.text.trim();
      // if(password != confirmpassword){
      //   Text("password does not match");
      //   setState(() {
      //     _isRegistering = false;
      //   });
      //
      //   return;
      // }
      setState(() {
        _isRegistering = false;
      });

      try {
        final response = await Dio().post(
          'http://192.168.2.111:9999/api/vendor/register',
          data: {
            'name': name,
            'username':username,
            'password': password,
            // 'confirm password':confirmpassword,
            'email': email,
          },
        );
        print(response.statusCode);
        if(response.statusCode==200){
          print("Ok");
        }else{
          print("Don't");
        }


        if (response.statusCode == 200) {
          // final responseData = json.decode(response.data);
          // final token = responseData['token'];
          //
          // await _storage.write(key: 'token', value: token);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        } else {
          final errorMessage = response.data['message'];
          showDialog(
            context:context,
            builder: (context) => AlertDialog(
              title: Text('Error'),
              content: Text(errorMessage),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Ok'),
                ),
              ],
            ),
          );
        }
      } catch (error) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            // content: Text(error.toString()),
            content:SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Connection Error'),
                ],
              ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(20.0)),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }

      setState(() {
        _isRegistering = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      resizeToAvoidBottomInset:false ,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Form(
        key: _key,
        child: Column(
          //  mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Multivendor",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Welcome !",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Regiester For Your Account",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500)
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
              child: TextFormField(
                controller: nameController,
                decoration:  InputDecoration(
                  prefixIcon:Icon(Icons.person),
                  border:OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  hintText: "Enter Your name",
                  label: Text("Name"),

                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
              child: TextFormField(
                controller: usernamecontroller,
                decoration:  InputDecoration(
                  prefixIcon:Icon(Icons.person),
                  border:OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  hintText: "Enter Your username",
                  label: Text("User Name"),

                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
              child: TextFormField(
                controller: emailController,
                decoration:  InputDecoration(
                  prefixIcon:Icon(Icons.email),
                  border:OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  hintText: "Email",
                  label: Text("Email"),
                ),

                textInputAction: TextInputAction.next,
                keyboardType:TextInputType.emailAddress ,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please contains @ for email';
                  }
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
              child: TextFormField(
                controller: passwordController,
                keyboardType: TextInputType.number,
                decoration:  InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed:_toggleObscureText,
                  ),
                  prefixIcon:Icon(Icons.key),
                  border:OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  hintText: "Enter Your Password",
                  label: Text("Password"),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty ) {
                    return 'Password Field is required';
                  }
                  return null;
                },

              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
            //   child: TextFormField(
            //       controller: confirmpasswordController,
            //       decoration:  InputDecoration(
            //         suffixIcon: IconButton(
            //           icon: Icon(
            //             _obscureText2 ? Icons.visibility_off : Icons.visibility,
            //           ),
            //           onPressed:_toggleObscureText2,
            //         ),
            //         prefixIcon:Icon(Icons.key),
            //         border:OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            //         hintText: "Enter Your Confirm Password",
            //         label: Text("Confirm Password"),
            //       ),
            //       validator: (value) {
            //         if (value!.isEmpty)
            //           return " Confirm Paswword field required";
            //         if (value != passwordController.text)
            //           return "Password and Confrim password is not same";
            //       }),
            // ),
            // SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed:_register,
                child: _isRegistering
                    ? SizedBox(
                  height: 20.0,
                  width: 20.0,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
                    : Text('Create Account'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Do You Have a Account !",style: TextStyle(fontSize: 16),),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>LoginScreen(),
                          ));
                    },
                    child: Text("Login",style: TextStyle(fontSize: 17,fontStyle:FontStyle.italic),))
              ],
            )
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, String info) {
    // set up the buttons
    Widget okButton = ElevatedButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Registration"),
      content: Text(
        info,
        style: const TextStyle(color: Colors.green),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}