import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class CreateBrandPage extends StatefulWidget {
  const CreateBrandPage({Key? key}) : super(key: key);

  @override
  _CreateBrandPageState createState() => _CreateBrandPageState();
}

class _CreateBrandPageState extends State<CreateBrandPage> {
  final _formKey = GlobalKey<FormState>();

  final _brandNameController = TextEditingController();
  final _brandImageController = TextEditingController();

  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final response = await Dio().post(
          // 'https://ziizii.mickhae.com/api/vendor/brand',
          'https://ziizii.mickhae.com/vendor/brand',
          data: {
            'brand_name': _brandNameController.text,
            'brand_image': _brandImageController.text,
          },
        );

        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Brand created successfully!'),
            duration: Duration(seconds: 2),
          ),
        );

        // Navigate to the brand list screen
        Navigator.pop(context);
      } catch (error) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Error creating brand: ${error.toString()}';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Brand'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _brandNameController,
                decoration: InputDecoration(labelText: 'Brand Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the brand name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _brandImageController,
                decoration: InputDecoration(labelText: 'Brand Image URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the brand image URL';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: _isLoading ? null : _submitForm,
                child: _isLoading ? CircularProgressIndicator() : Text('Create'),
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
