

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendor/pages/Category%20Page/category.dart';

class CreateCategoryPage extends StatefulWidget {
  const CreateCategoryPage({Key? key}) : super(key: key);


  @override
  State<CreateCategoryPage> createState() => _CreateCategoryPageState();
}


class _CreateCategoryPageState extends State<CreateCategoryPage> {

  final _formKey = GlobalKey<FormState>();

  final _CategoryNameController = TextEditingController();
  // final _CategoryImageController = TextEditingController();

  bool _isLoading = false;
  String _errorMessage = '';
  File? _singleImage;
  final picker=ImagePicker();
  String? singleImageBase64;
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
      String singleImageBase =
          'data:image/png;base64,' + base64Encode(singleImageBytes);
      singleImageBase64 = singleImageBase;
      print(singleImageBase64);
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {



      try {
        setState(() {
          _isLoading = true;
        });
        Options options = Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        );
        FormData formData = FormData();

        if (_singleImage != null) {
          // Convert single image file to Base64
          List<int> singleImageBytes = await _singleImage!.readAsBytes();
          String singleImageBase64 =
              'data:image/png;base64,' + base64Encode(singleImageBytes);
          // Get the file extension
          String extension = _singleImage!.path.split('.').last;
          print(singleImageBase64);
          formData.files.add(
            MapEntry(
              'category_image',
              // MultipartFile.fromBytes(singleImageBytes,),
              MultipartFile.fromString(singleImageBase64),
            ),
          );
          // Create a FormData object to send multipart/form-data
        }
        formData.fields.addAll([
          MapEntry('category_name',  _CategoryNameController.text),
        ]);
        final response = await Dio().post(
          // 'https://ziizii.mickhae.com/api/vendor/category',
          'https://ziizii.mickhae.com/api/vendor/category',
          // data: {
          //   'category_name': _CategoryNameController.text,
          //   'category_image':_CategoryImageController.text,
          // },
          data:formData,
          options: options,
        );

        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Category created successfully!'),
            duration: Duration(seconds: 2),
          ),
        );

        // Navigate to the brand list screen
        // Navigator.pop(context);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Category_page()
            ), (route) => false);
      } catch (error) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Error creating Category: ${error.toString()}';
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Category'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _CategoryNameController,
                decoration: InputDecoration(labelText: 'Category Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Category name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              // TextFormField(
              //   controller:_CategoryImageController,
              //   decoration: InputDecoration(labelText: 'Category Image URL'),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter the Category image URL';
              //     }
              //     return null;
              //   },
              // ),
              // For Single Image
              ElevatedButton(
                onPressed: _getSingleImage,
                child: Text('Choose Category Image'),
              ),
              if (_singleImage != null)
                Image.file(
                  _singleImage!,
                  height: 200,
                ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: _isLoading ? null : _submitForm,
                child: _isLoading ? CircularProgressIndicator() : Text(
                    'Create'),
              ),
              SizedBox(height: 16),
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );



  }
}
