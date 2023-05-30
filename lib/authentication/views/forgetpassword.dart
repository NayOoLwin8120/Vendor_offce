import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vendor/pages/secondpage.dart';
import 'package:vendor/validatiion/login_page1.dart';

class ForgetPassword extends StatefulWidget {
  int? id;
   ForgetPassword({Key? key,this.id}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey = GlobalKey<FormState>();
  final _oldpasswordController = TextEditingController();
  final _newpasswordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();

  bool _obscureText = true;
  bool _obscureText2 = true;
  bool _obscureText3 = true;

  bool _isLoading = false;
  String _errorMessage = '';
  // void dispose() {
  //   _oldpasswordController.dispose();
  //   _newpasswordController.dispose();
  //   super.dispose();
  // }
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
  void _toggleObscureText3() {
    setState(() {

      _obscureText3 = !_obscureText3;
    });
  }
  Future<void> _submitForm() async {
    print(widget.id);
    print(widget.id.runtimeType);
    print(widget.id.toString().runtimeType);




    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      try {
        print("data");
        setState(() {
          _isLoading = true;
          _errorMessage = '';
        });



        // Make the POST request to the API
        Response response = await Dio().post(

          'https://ziizii.mickhae.com/api/vendor/password/update',

          data: {
            'old_password':_oldpasswordController.text,
            'new_password': _newpasswordController.text,
            'confirm_password': _confirmpasswordController.text,
            'id':widget.id.toString(),


          },

        );
        print("data 3");

        // Check the response status
        if (response.statusCode == 200) {
          print("ok");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('password updated successfully!'),
              duration: Duration(seconds: 2),
            ),
          );
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Second()));
          // Handle the success scenario here
        } else if(response.statusCode == 422)  {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(response!.data['message']),
              content: Text("please Try Again !"),
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
        if (error is DioError) {

          if (error.response != null) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(error.response!.data['message']),
                content: Text("please Try Again !"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('OK'),
                  ),
                ],
              ),
            );
            print('Response status: ${error.response!.statusCode}');
            print('Response data: ${error.response!.data}');
          }
        } else {
          // print('An error occurred: $error');
        }
        // Handle any errors that occurred during the API request
        setState(() {
          _errorMessage = 'An error occurred: $error';
          print(_errorMessage);
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot password page"),
      ),
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


                  //______________for old password field
                  SizedBox(height: 32.0),
                  TextFormField(
                    controller: _oldpasswordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      hintText: 'Enter Your Old Password',
                      prefixIcon: Icon(Icons.key),
                      suffixIcon: IconButton(
                        onPressed: _toggleObscureText,
                        icon: Icon(
                          _obscureText ? Icons.visibility : Icons
                              .visibility_off,
                        ),
                      ),
                      border:OutlineInputBorder(borderRadius:BorderRadius.circular(12)),

                      labelText: " Old Password ",
                      labelStyle: TextStyle(color: Colors.black),
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your old  password';
                      }

                      return null;
                    },
                  ),

                  SizedBox(height: 16.0),

                  //__________ password  Field
                  TextFormField(
                    controller: _newpasswordController,
                    obscureText: _obscureText2,
                    decoration: InputDecoration(
                      hintText: 'Enter Your New Password',
                      prefixIcon: Icon(Icons.key),
                      suffixIcon: IconButton(
                        onPressed: _toggleObscureText2,
                        icon: Icon(
                          _obscureText2 ? Icons.visibility : Icons
                              .visibility_off,
                        ),
                      ),
                      border:OutlineInputBorder(borderRadius:BorderRadius.circular(12)),

                      labelText: "New Password ",
                      labelStyle: TextStyle(color: Colors.black),
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your new  password';
                      }
                      if (value.length < 6) {
                        return 'Password should be at least 6 characters long';
                      }
                      return null;
                    },
                  ),
                  //___________For confirm Password Field
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _confirmpasswordController,
                    obscureText: _obscureText3,
                    decoration: InputDecoration(
                      hintText: 'Enter Your Confirm  Password',
                      prefixIcon: Icon(Icons.key),
                      suffixIcon: IconButton(
                        onPressed: _toggleObscureText3,
                        icon: Icon(
                          _obscureText3 ? Icons.visibility : Icons
                              .visibility_off,
                        ),
                      ),
                      border:OutlineInputBorder(borderRadius:BorderRadius.circular(12)),

                      labelText: "Confirm Password ",
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
                      if(value != _newpasswordController.text){
                        return 'New password and confim passwrod are not the same';
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
                      onPressed: _isLoading? null : () =>
                         _submitForm(),
                      child: _isLoading
                          ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                          : Text(
                        'Forgot password',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
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
