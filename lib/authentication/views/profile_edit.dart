import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vendor/authentication/controllers/profile_update_controller.dart';
import 'package:vendor/authentication/models/user_detail_model.dart';
import 'package:vendor/custom_config/util/custom_image_convetor.dart';
import 'package:vendor/pages/secondpage.dart';


class ProfileEditPage extends StatefulWidget {
  final Map<String, dynamic> userData;

  const ProfileEditPage({Key? key,required this.userData}) : super(key: key);

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {



  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _shortinfoController = TextEditingController();
  TextEditingController _vedorjoinController = TextEditingController();





  final picker = ImagePicker();
  String singleImageBase64='';
  File? _singleImage;
  bool _isLoading = false;
  String _errorMessage = '';



  Future<void> _getSingleImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _singleImage = File(pickedFile.path);
      });

    }
    if (_singleImage != null) {
      // Convert single image file to Base64
      List<int> singleImageBytes = await _singleImage!.readAsBytes();
      String singleImageBase = 'data:image/png;base64,' + base64Encode(singleImageBytes);
      singleImageBase64=singleImageBase;
      print(singleImageBase64);

    }
  }

  // void _onUpdateDataPressed(BuildContext context){
  //   final name = _nameController.text.trim();
  //   final username = _usernameController.text.trim();
  //   final phonenumber = _phoneController.text.trim();
  //   final email = _emailController.text.trim();
  //   print(email);
  //   final shortinfo = _shortinfoController.text.trim();
  //   final address = _addressController.text.trim();
  //   final vendor_join = _vedorjoinController.text.trim();
  //   final image=singleImageBase64;
  //   if (_formKey.currentState != null && _formKey.currentState!.validate()) {
  //     try {
  //       setState(() {
  //         _isLoading = true;
  //         _errorMessage = '';
  //       });
  //
  //
  //
  //       print(singleImageBase64);
  //
  //
  //     _controller
  //           .authenticate(
  //           context,
  //           name,
  //           username,
  //           email,
  //           phonenumber,
  //           address,
  //           shortinfo,
  //           vendor_join,
  //           image)
  //           .then((value) {});
  //     }catch(error){
  //       print(error);
  //     }
  //   }
  // }
  Future<void> _submitForm() async {
    print(widget.userData['data']['id']);



    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      try {
        print("data");
        setState(() {
          _isLoading = true;
          _errorMessage = '';
        });
        print(_nameController.text.runtimeType);
        print(_shortinfoController.text);
        print(_emailController.text);
        print(_phoneController.text);
        print(_addressController.text);
        print(_vedorjoinController.text);
        print(singleImageBase64);
        Options options = Options(
          // followRedirects: true,
          headers: {
            'Content-Type': 'application/json',
            // 'Content-Type': 'applicatio/json',

          },
        );

        // Make the POST request to the API
        Response response = await Dio().post(

          'https://ziizii.mickhae.com/api/vendor/profile/update/${widget.userData['data']['id']}',

          data: {
            'name':_nameController.text,
            'email': _emailController.text,
            'phone': _phoneController.text,
            'address':_addressController.text,
            'vendor_join': _vedorjoinController.text,
            'vendor_short_info': _shortinfoController.text,
            'photo':singleImageBase64,

          },
          options: options,
        );
        print("data 3");

        // Check the response status
        if (response.statusCode == 200) {
          print("ok");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Profile updated successfully!'),
              duration: Duration(seconds: 2),
            ),
          );



          Navigator.push(context, MaterialPageRoute(builder: (context)=>Second()));






          // Handle the success scenario here
        } else {
          // Handle the failure scenario here
          setState(() {
            _errorMessage = 'Failed to send data to the API';
            print(_errorMessage);
          });
        }
      } catch (error) {
        if (error is DioError) {
          print('DioError: ${error.message}');
          if (error.response != null) {
            print('Response status: ${error.response!.statusCode}');
            print('Response data: ${error.response!.data}');
          }
        } else {
          print('An error occurred: $error');
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
  void initState() {
    super.initState();
    _nameController.text = widget.userData['data']['name'] ?? '';
    _usernameController.text = widget.userData['data']['username'] ?? '';
    _emailController.text = widget.userData['data']['email'] ?? '';
    _phoneController.text = widget.userData['data']['phone'] ?? '';
    _addressController.text = widget.userData['data']['address'] ?? '';
    _shortinfoController.text = widget.userData['data']['vendor_short_info'] ?? '';
    _vedorjoinController.text = widget.userData['data']['vendor_join'] ?? '';
  }
  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _shortinfoController.dispose();
    _vedorjoinController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Edit Profile'),
    ),
    body: Form(
    key: _formKey,
    child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      const SizedBox(height: 20),
      Center(
      child: GestureDetector(
      onTap: () {
             _getSingleImage();
        },
      child: CircleAvatar(
      radius: 50,
      // backgroundImage:
      // imagelocal!=null ? Image.file(imagelocal!,width:160,height:160,fit:BoxFit.cover).image :
      // NetworkImage('${widget.userData['data']['photo']}') as ImageProvider<Object> ,
      //   backgroundImage: widget.userData['data']['photo'] != null
      //   ? NetworkImage(widget.userData['data']['photo'].toString()) as ImageProvider<Object>?
      //       : NetworkImage(url),

        backgroundImage: (_singleImage != null)
            ? Image.file(
          _singleImage!,
          height: 200,
        ).image
            : (widget.userData['data']['photo'] != null)
            ? NetworkImage(
          widget.userData['data']['photo'].toString(),
        )
            : null,


        child: Icon(
      Icons.camera_alt,
      size: 30,
      color: Colors.white.withOpacity(0.7),
      ),
      ),
      ),
      ),
      const SizedBox(height: 30),
      Text(
      'Name',
      style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).primaryColor,
      ),
      ),
      const SizedBox(height: 10),
      TextFormField(
      controller: _nameController,
      decoration: InputDecoration(
      hintText: 'Enter your name',
      border: OutlineInputBorder(),
      ),

      validator: (value) {
      if (value!.isEmpty) {
      return 'Please enter your name';
      }
      return null;
      },
      ),
      const SizedBox(height: 20),
        Text(
          'UserName',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _usernameController,
          decoration: InputDecoration(
            hintText: 'Enter your username',
            border: OutlineInputBorder(),
          ),

          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your username';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
      Text(
      'Email',
      style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).primaryColor,
      ),
      ),
      const SizedBox(height: 10),
      TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
      hintText: 'Enter your email',
      border: OutlineInputBorder(),
      ),
      validator: (value) {
      if (value!.isEmpty) {
      return 'Please enter your email';
      } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return 'Please enter a valid email';
      }
      return null;
      },
      ),
      const SizedBox(height: 20),
      Text(
      'Phone Number',
      style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).primaryColor,
      ),
      ),
      const SizedBox(height: 10),
      TextFormField(
      controller: _phoneController,
      decoration: InputDecoration(
      hintText: 'Enter your phone number',
      border: OutlineInputBorder(),
      ),
      validator: (value) {
      if (value!.isEmpty) {
      return 'Please enter your phone number';
      }
      return null;
      },
      ),
        SizedBox(height: 30,),
        Text(
          'Short_info',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),

        const SizedBox(height: 10),
        TextFormField(
          controller: _shortinfoController,
          decoration: InputDecoration(
            hintText: 'Enter your Short Description',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter Short  Description';
            }
            return null;
          },
        ),

        SizedBox(height: 30,),
        Text(
          'Vendor_join',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),

        const SizedBox(height: 10),
        TextFormField(
          controller: _vedorjoinController,
          decoration: InputDecoration(
            hintText: 'Vendor_join',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter Short  Description';
            }
            return null;
          },
        ),
        SizedBox(height: 30,),
        Text(
          'Address',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),

        const SizedBox(height: 10),
        TextFormField(
          controller: _addressController,
          decoration: InputDecoration(
            hintText: 'Enter your address',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your address';
            }
            return null;
          },
        ),
      const SizedBox(height: 30),
      Center(
        child :ElevatedButton(
          onPressed: _isLoading ? null : _submitForm,
          child: _isLoading
              ? CircularProgressIndicator()
              : Text('Update Data'),
        ),


      ),

        ],
      ),
    ),
    ),
    ),
    );
  }


}