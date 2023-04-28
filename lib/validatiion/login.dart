

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lottie/lottie.dart';
// import 'package:multi/pages/home.dart';
// import 'package:multi/pages/userdetail.dart';
// import 'package:multi/pages/validation/regiester_model.dart';
import 'package:vendor/pages/homepage.dart';
import 'package:vendor/validatiion/regiester.dart';



class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<FormState>();

  final _storage = FlutterSecureStorage();
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();
  bool _obscureText = true;

  final _formKey = GlobalKey<FormState>();

  bool _isAuthenticating = false;
  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> _authenticate() async {
    if (_formKey.currentState?.validate()==null) {
      setState(() {
        _isAuthenticating = true;
      });


      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      try {
        final response = await Dio().post(
          'http://192.168.2.111:9999/api/vendor/login',
          data: {
            'email': email,
            'password': password,
          },
        );

        if (response.statusCode == 200) {
          final responseData = response.data;
          final token = responseData['token'];

          await _storage.write(key: 'token', value: token);
          await _storage.write(key: 'username', value: email);
          await _storage.write(key: 'password', value: password);

          showDialog(
            context: context,
            builder: (BuildContext context) {

              return AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                title: Text('Login successful'),
                content: Text('Welcome to MultiOnline Shop'),
                // actions: [
                //   TextButton(
                //     child: Text('OK'),
                //     onPressed: () {
                //       Navigator.pushReplacement(
                //         context,
                //         MaterialPageRoute(builder: (context) => UserDetailsPage()),
                //       );
                //     },
                //   ),
                // ],
              );
            },
          );
          Future.delayed(Duration(seconds: 3), () {
            Navigator.pop(context);
            // Navigate to home page and remove all previous routes
            Navigator.pushReplacement(
              context,
              // MaterialPageRoute(builder: (context) => UserDetailsPage()),
              MaterialPageRoute(builder: (context) =>MyHomePage(title: "Home")),
            );
          });

          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (context) => UserDetailsPage()),
          // );
        } else {
          final errorMessage = response.data['message'];
          showDialog(
            context: errorMessage,
            builder: (context) => AlertDialog(
              title: Text('Error'),
              content: Text(errorMessage.toString()),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
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
            content: Text(error.toString()),
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
        _isAuthenticating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      body:
      Container(
        color:Color(0xFFa179f2),
        child: Column(children:
        [

          SizedBox(height:60),
          Container(
            child: Column(
              children: [
                Lottie.network(
                    "https://assets4.lottiefiles.com/packages/lf20_mjlh3hcy.json",
                    height: 200,
                    width: double.infinity),
                Form(
                  key: _key,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Container(

                        child: Text(
                          "Multivendor",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Text(
                        "Welcome!",
                        style:TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 16 / 2,
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Text(
                        "Login to continue",
                        style:TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.black54),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: TextFormField(
                          controller:_emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration:  InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            border:OutlineInputBorder(borderRadius:BorderRadius.circular(12)),
                            hintText: "Enter your email address",
                            labelText: "Email Address ",
                            labelStyle: TextStyle(color: Colors.black),
                            contentPadding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                          ),
                          validator: (value) =>
                          value!.isEmpty ? "Email field required" : null,
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: _obscureText,
                          decoration:  InputDecoration(
                            prefixIcon: Icon(Icons.key),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText ? Icons.visibility_off : Icons.visibility,color:Colors.black,
                              ),
                              onPressed: _toggleObscureText,
                            ),
                            border:OutlineInputBorder(borderRadius:BorderRadius.circular(12)),
                            hintText: "Enter Your Password",
                            labelText: "Password ",
                            labelStyle: TextStyle(color: Colors.black),
                            contentPadding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                          ),
                          validator: (value) =>
                          value!.isEmpty ? "Password field required" : null,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ElevatedButton(
                          onPressed: _authenticate,
                          child: _isAuthenticating
                              ? SizedBox(
                            height: 20.0,
                            width: 20.0,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                              : Text('Login'),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      Container(
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Do you have no account? ",style:TextStyle(fontSize: 20,fontWeight:FontWeight.w400)),
                              InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>SignupPage(),
                                    )),
                                child: Text(
                                  "Register Now",style:TextStyle(fontSize: 20,color: Colors.white38,fontStyle:FontStyle.italic,decoration:TextDecoration.underline),
                                ),
                              ),
                            ],
                          )
                      )
                    ],
                  ),

                ),

              ],
            ),
          ),
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