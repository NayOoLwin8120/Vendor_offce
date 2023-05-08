

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CreateCategoryPage extends StatefulWidget {
  const CreateCategoryPage({Key? key}) : super(key: key);


  @override
  State<CreateCategoryPage> createState() => _CreateCategoryPageState();
}


class _CreateCategoryPageState extends State<CreateCategoryPage> {
  final _formKey = GlobalKey<FormState>();

  final _CategoryNameController = TextEditingController();
  final _CategoryImageController = TextEditingController();

  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final response = await Dio().post(
          'http://192.168.2.111:9999/api/vendor/category',
          data: {
            'category_name': _CategoryNameController.text,
            'category_image':_CategoryImageController.text,
          },
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
        Navigator.pop(context);
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
              TextFormField(
                controller:_CategoryImageController,
                decoration: InputDecoration(labelText: 'Category Image URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Category image URL';
                  }
                  return null;
                },
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
