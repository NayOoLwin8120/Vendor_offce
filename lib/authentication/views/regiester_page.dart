import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vendor/authentication/controllers/login_controller.dart';
import 'package:vendor/authentication/controllers/regiester_controller.dart';
import 'package:vendor/authentication/views/login_page.dart';
class RegiesterPage extends StatefulWidget {
  const RegiesterPage({Key? key}) : super(key: key);

  @override
  State<RegiesterPage> createState() => _RegiesterPageState();
}

class _RegiesterPageState extends State<RegiesterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;
  bool _isAuthenticating = false;

  final RegiesterController _controller = RegiesterController();
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
      final name = _nameController.text.trim();
      final username = _usernameController.text.trim();
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      _controller.authenticate(context,name,username,email, password)
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5.0),
                  Center(
                    child:
                    Lottie.network(
                        "https://assets4.lottiefiles.com/packages/lf20_mjlh3hcy.json",
                        height: 200,
                        width: double.infinity,
                        ),

                  ),
                  SizedBox(height: 10.0),
                  Center(
                    child: Text(
                      'MultiVendor Online Shop',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'You Can Regiester As A Vendor! ',
                        style: TextStyle(

                          color: Colors.black38,
                        ),
                      ),
                      Text(
                        'Welcome To MultiVendor Online Shop',
                        style: TextStyle(

                          color: Colors.black38,
                        ),
                      ),
                    ],
                  ),
                  //______________for name field
                  SizedBox(height: 32.0),
                  TextFormField(
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    decoration:  InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      border:OutlineInputBorder(borderRadius:BorderRadius.circular(12)),
                      hintText: "Enter your name",
                      labelText: "Name ",
                      labelStyle: TextStyle(color: Colors.black),
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                      // errorStyle:TextStyle(color:Colors.black),
                    ),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      // if (!value.contains('@') || !value.contains('.')) {
                      //   return 'Please enter a valid email address';
                      // }
                      return null;
                    },
                  ),
                  //__________For username Field
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _usernameController,
                    keyboardType: TextInputType.name,
                    decoration:  InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      border:OutlineInputBorder(borderRadius:BorderRadius.circular(12)),
                      hintText: "Enter your Username",
                      labelText: "Username",
                      labelStyle: TextStyle(color: Colors.black),
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                      // errorStyle:TextStyle(color:Colors.black),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }

                      return null;
                    },
                  ),
                  //__________ For email Field
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration:  InputDecoration(
                      prefixIcon: Icon(Icons.email_sharp),
                      border:OutlineInputBorder(borderRadius:BorderRadius.circular(12)),
                      hintText: "Enter your email ",
                      labelText: "Email ",
                      labelStyle: TextStyle(color: Colors.black),
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                      // errorStyle:TextStyle(color:Colors.black),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email address';
                      }
                      if (!value.contains('@') || !value.contains('.')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  //___________For Password Field
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      hintText: 'Enter Your Password',
                      prefixIcon: Icon(Icons.key),
                      suffixIcon: IconButton(
                        onPressed: _toggleObscureText,
                        icon: Icon(
                          _obscureText ? Icons.visibility : Icons
                              .visibility_off,
                        ),
                      ),
                      border:OutlineInputBorder(borderRadius:BorderRadius.circular(12)),

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
                  //______ End For password Field
                  SizedBox(height: 16.0),
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
                        'Create Account',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                      width:double.infinity,
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Do You Have A Account? ",),
                          InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>LoginScreen2(),
                                )),
                            child: Text(
                              "Please Login!",style:TextStyle(color: Colors.blue,fontStyle:FontStyle.italic),
                            ),
                          ),
                        ],
                      )
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
