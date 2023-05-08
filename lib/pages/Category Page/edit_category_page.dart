import 'package:flutter/material.dart';
import 'package:vendor/controllers/Category%20Page%20Controller/category_page_controller.dart';

class EditCategoryPage extends StatefulWidget{
  int id;
  String name;
  String imageUrl;
   EditCategoryPage({required this.id, required this.name, required this.imageUrl,Key? key}) : super(key: key);

  @override
  State<EditCategoryPage> createState() => _EditCategoryPageState();
}

class _EditCategoryPageState extends State<EditCategoryPage> {
  final CategoryApiController _edit=CategoryApiController();
  final _formKey = GlobalKey<FormState>();

  final _CategoryNameController = TextEditingController();
  final _CategoryImageController = TextEditingController();

  bool _isLoading = false;
  String _errorMessage = '';
  @override
  void initState() {
    super.initState();
    _CategoryNameController.text = widget.name!;
    _CategoryImageController.text = widget.imageUrl!;
  }
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await _edit.editCategory(
          id: widget.id!,
          name: _CategoryNameController.text,
          imageUrl: _CategoryImageController.text,
        );

        setState(() {
          _isLoading = false;
          widget.name = _CategoryNameController.text;
          widget.imageUrl = _CategoryImageController.text;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Category updated successfully!'),
            duration: Duration(seconds: 2),
          ),
        );

        // Navigate to the brand list screen
        Navigator.pop(context);
      } catch (error) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Error updating Category: ${error.toString()}';
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Category'),
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
                controller: _CategoryImageController,
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
