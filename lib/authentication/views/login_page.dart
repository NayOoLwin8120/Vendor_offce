import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vendor/authentication/controllers/login_controller.dart';
import 'package:vendor/authentication/views/regiester_page.dart';

class LoginScreen2 extends StatefulWidget {
  const LoginScreen2({Key? key}) : super(key: key);

  @override
  State<LoginScreen2> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen2> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;
  bool _isAuthenticating = false;


  final LoginController _controller = LoginController();
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }
  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  void _onLoginPressed(BuildContext context) {
    if (_formKey.currentState?.validate() == true) {
      setState(() {
        _isAuthenticating = true;
      });
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      _controller.authenticate(context,email, password)
          .then((value) {
        setState(() {
          _isAuthenticating = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(

          // color:Color(0xFFd8d7d9),
          // color:Color(0xFFd8d7d9),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.0),
                    Lottie.network(
                        "https://assets4.lottiefiles.com/packages/lf20_mjlh3hcy.json",
                        height: 200,
                        width: double.infinity,
                        ),
                  SizedBox(height: 20.0),
                  Center(
                    child: Text(
                      'Multivendor Online Shop',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'You can Login As A Vendor To Your Account',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 32.0),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration:  InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      border:OutlineInputBorder(borderRadius:BorderRadius.circular(12)),
                      hintText: "Enter your email address",
                      labelText: "Email Address ",
                      labelStyle: TextStyle(color: Colors.black),
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                      // errorStyle:TextStyle(color:Colors.black),
                    ),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                       return "Please enter your email address"
                       ;
                      }
                      if (!value.contains('@') || !value.contains('.')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password should be at least 6 characters long';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 32.0),
                  SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: _isAuthenticating ? null : () =>
                          _onLoginPressed(context),
                      child: _isAuthenticating
                          ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                          : Text(
                        'Login',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),



                  Container(
                    width:double.infinity,
                      child:Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Do you have no account? ",),
                          InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>RegiesterPage(),
                                )),
                            child: Text(
                              "Register Now!",style:TextStyle(color: Colors.blue,fontStyle:FontStyle.italic),
                            ),
                          ),
                        ],
                      )
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
