import 'package:flutter/material.dart';

import 'package:vendor/controllers/Brand%20Page%20Controller/brand_controller.dart';


class EditBrand extends StatefulWidget {
  // final int id;
  // final String name;
  // final String imageUrl;
   int id;
   String name;
   String imageUrl;

  EditBrand({required this.id, required this.name, required this.imageUrl, Key? key}) : super(key: key);

  @override
  _EditBrandState createState() => _EditBrandState();
}

class _EditBrandState extends State<EditBrand> {
  final BrandApiController _edit=BrandApiController();
  final _formKey = GlobalKey<FormState>();

  final _brandNameController = TextEditingController();
  final _brandImageController = TextEditingController();

  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _brandNameController.text = widget.name!;
    _brandImageController.text = widget.imageUrl!;
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await _edit.editBrand(
          id: widget.id!,
          name: _brandNameController.text,
          imageUrl: _brandImageController.text,
        );

        setState(() {
          _isLoading = false;
          widget.name = _brandNameController.text;
          widget.imageUrl = _brandImageController.text;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Brand updated successfully!'),
            duration: Duration(seconds: 2),
          ),
        );

        // Navigate to the brand list screen
        Navigator.pop(context);
      } catch (error) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Error updating brand: ${error.toString()}';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Brand'),
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
                child: _isLoading ? CircularProgressIndicator() : Text('Update'),
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
