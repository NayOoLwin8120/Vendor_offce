import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vendor/Model/Category%20Page%20Model%20/category_page_model.dart';
import 'package:vendor/controllers/Category%20Page%20Controller/Sub_Category%20Page%20Controller/sub_category_page_controller.dart';
import 'package:vendor/controllers/Category%20Page%20Controller/category_page_controller.dart';

class EditSubCategoryPage extends StatefulWidget{
  int id;
  String categoryname;
  String subcategoryname;
  EditSubCategoryPage({required this.id, required this.categoryname, required this.subcategoryname,Key? key}) : super(key: key);

  @override
  State<EditSubCategoryPage> createState() => _EditSubCategoryPageState();
}

class _EditSubCategoryPageState extends State<EditSubCategoryPage> {
  final CategoryApiController _category=CategoryApiController();
  final SubCategoryApiController _editsub=SubCategoryApiController();
  final _formKey = GlobalKey<FormState>();


  final _SubCategoryNameController = TextEditingController();
  int? selectedCategoryId;
  String  categoryIdString='';

  bool _isLoading = false;
  String _errorMessage = '';
  @override
  void initState() {
    super.initState();

    _SubCategoryNameController.text = widget.subcategoryname!;
  }

  // void initState() {
  //   super.initState();
  //   _CategoryNameController.text = widget.name!;
  //   _CategoryImageController.text = widget.imageUrl!;
  // }

    // if (_formKey.currentState != null && _formKey.currentState!.validate()) {
    //   setState(() {
    //     _isLoading = true;
    //   });
    //
    //   try {
    //     await _edit.editCategory(
    //       id: widget.id!,
    //       name: _CategoryNameController.text,
    //       imageUrl: _CategoryImageController.text,
    //     );
    //
    //     setState(() {
    //       _isLoading = false;
    //       widget.name = _CategoryNameController.text;
    //       widget.imageUrl = _CategoryImageController.text;
    //     });
    //
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: Text('Category updated successfully!'),
    //         duration: Duration(seconds: 2),
    //       ),
    //     );
    //
    //     // Navigate to the brand list screen
    //     Navigator.pop(context);
    //   } catch (error) {
    //     setState(() {
    //       _isLoading = false;
    //       _errorMessage = 'Error updating Category: ${error.toString()}';
    //     });
    //   }
    // }

  // Future<void> _submitForm() async {
  //   print(selectedCategoryId);
  //   print(selectedCategoryId.runtimeType);
  //   categoryIdString=selectedCategoryId.toString();
  //   print(categoryIdString);
  //   print(categoryIdString.runtimeType);
  //   if (_formKey.currentState != null && _formKey.currentState!.validate()) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //
  //     try {
  //
  //       if(categoryIdString != null){
  //         final response = await Dio().post(
  //           'http://192.168.100.23:9999/api/vendor/subcategory',
  //           data: {
  //             'category_id':categoryIdString ,
  //             'subcategory_name':_SubCategoryNameController.text,
  //           },
  //         );
  //       }else{
  //         print("data is null");
  //       }
  //
  //
  //       setState(() {
  //         _isLoading = false;
  //       });
  //
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Sub Category  created successfully!'),
  //           duration: Duration(seconds: 2),
  //         ),
  //       );
  //
  //       // Navigate to the brand list screen
  //       Navigator.pop(context);
  //     } catch (error) {
  //       setState(() {
  //         _isLoading = false;
  //         _errorMessage = 'Error creating SubCategory: ${error.toString()}';
  //         print(_errorMessage);
  //       });
  //     }
  //   }
  // }
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        categoryIdString = selectedCategoryId.toString();
      });

      try {
        await _editsub.editSubCategory(
          id: widget.id!,
          subcategoryName:_SubCategoryNameController.text,
          categoryId:categoryIdString ?? '',

        );

        setState(() {
          _isLoading = false;

        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sub Category updated successfully!'),
            duration: Duration(seconds: 2),
          ),
        );
        // Update the widget with the new data
        setState(() {
          widget.subcategoryname = _SubCategoryNameController.text;
        });
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
                controller: _SubCategoryNameController,
                decoration: InputDecoration(labelText: 'SubCategorynanme'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Category name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              FutureBuilder<CategoryApiResponse>(
                future: _category.getData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(child: Text("Data are Loading")),
                            Center(child: CircularProgressIndicator()),
                          ],
                        ),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error fetching data'));
                    }
                    final apiResponse = snapshot.data!;

                    return Column(
                      children: [
                        DropdownButton<int>(
                          isExpanded:true,
                          items: apiResponse.data.map((category) {
                            return DropdownMenuItem<int>(
                              child: Text(category.category_name.toString()),
                              value: category.id,
                            );
                          }).toList(),
                          onChanged: (int? selectedId) {
                            setState(() {
                              selectedCategoryId = selectedId;
                              print(selectedId);
                            });
                          },
                          value: selectedCategoryId,
                          hint:Text(widget.categoryname),
                        ),
                        selectedCategoryId != null
                            ? Text('Selected category: ${apiResponse.data.firstWhere((category) => category.id == selectedCategoryId).category_name}')
                            : SizedBox.shrink(),

                      ],
                    );
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return Center(
                      child: Column(
                        children: [
                          Lottie.network(
                            "https://assets3.lottiefiles.com/packages/lf20_JUr2Xt.json",
                            width: double.infinity,
                            fit: BoxFit.fill,
                          ),
                          Text(
                            'No Internet Connection',
                            style: TextStyle(fontSize: 22, color: Colors.red),
                          ),
                        ],
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
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