import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vendor/Model/Category%20Page%20Model%20/category_page_model.dart';
import 'package:vendor/controllers/Category%20Page%20Controller/category_page_controller.dart';

class SubcategoryForm extends StatefulWidget {
  @override
  _SubcategoryFormState createState() => _SubcategoryFormState();
}

class _SubcategoryFormState extends State<SubcategoryForm> {
  final _categoryApiController = CategoryApiController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String _errorMessage = '';
  TextEditingController _SubCategoryNameController = TextEditingController();
  int? selectedCategoryId;
   String  categoryIdString='';

   // Start For Cartgory dropdown Testing
  List<Data> categoryList = [];
  //End For Cartgory dropdown Testing

  // Start For Cartgory dropdown Testing
  @override
  void initState() {
    super.initState();

    // Example code for fetching category data
    _categoryApiController.getData().then((response) {
      setState(() {
        categoryList = response.data;
      });
    });


  }




  Future<void> _submitForm() async {
    print(selectedCategoryId);
    print(selectedCategoryId.runtimeType);
    categoryIdString=selectedCategoryId.toString();
    print(categoryIdString);
    print(categoryIdString.runtimeType);
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        print(categoryIdString);
        print(_SubCategoryNameController.text);
        if(categoryIdString != null){
          final response = await Dio().post(
            // 'https://ziizii.mickhae.com/api/vendor/subcategory',
            'https://ziizii.mickhae.com/api/vendor/subcategory',
            data: {
              'category_id':categoryIdString ,
              'subcategory_name':_SubCategoryNameController.text,
            },
          );
        }else{
          print("data is null");
        }


        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sub Category  created successfully!'),
            duration: Duration(seconds: 2),
          ),
        );

        // Navigate to the brand list screen
        Navigator.pop(context);
      } catch (error) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Error creating SubCategory: ${error.toString()}';
          print(_errorMessage);
        });
      }
    }
  }
 // Start For Original Code
  // @override
  // void initState() {
  //   super.initState();
  //   // _loadData();
  // }
  // End For Original Code

  // Future<void> _loadData() async {
  //   final categoryApiResponse = await _categoryApiController.getData();
  //   final categoryList = <CategoryApiResponse>[];
  //   for (final category in categoryApiResponse.data) {
  //     final apiResponse = CategoryApiResponse(
  //       total: categoryApiResponse.total,
  //       message: categoryApiResponse.message,
  //       data: [category],
  //     );
  //     categoryList.add(apiResponse);
  //   }
  //   setState(() {
  //     _categoryList = categoryList;
  //   });
  // }
  // Future<void> _loadData() async {
  //   final CategoryApiResponse categoryApiResponse = await _categoryApiController.getCategories();
  //   setState(() {
  //     _categoryList = categoryApiResponse.map((category) => category.data).expand((data) => data).toList();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Subcategory'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children:
                  [
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _SubCategoryNameController,
                      decoration: InputDecoration(labelText: 'Category Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Category name';
                        }
                        return null;
                      },
                    ),

                    // Start For Category Dropdown Code
                    // FutureBuilder<CategoryApiResponse>(
                    //   future: _categoryApiController.getData(),
                    //   builder: (context, snapshot) {
                    //     if (snapshot.hasData) {
                    //       if (snapshot.connectionState == ConnectionState.waiting) {
                    //         return Center(
                    //           child: Column(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             children: [
                    //               Center(child: Text("Data are Loading")),
                    //               Center(child: CircularProgressIndicator()),
                    //             ],
                    //           ),
                    //         );
                    //       }
                    //       if (snapshot.hasError) {
                    //         return Center(child: Text('Error fetching data'));
                    //       }
                    //       final apiResponse = snapshot.data!;
                    //
                    //       return Column(
                    //             children: [
                    //               DropdownButton<int>(
                    //                 isExpanded:true,
                    //                 items: apiResponse.data.map((category) {
                    //                   return DropdownMenuItem<int>(
                    //                     child: Text(category.category_name.toString()),
                    //                     value: category.id,
                    //                   );
                    //                 }).toList(),
                    //                 onChanged: (int? selectedId) {
                    //                   setState(() {
                    //                     selectedCategoryId = selectedId;
                    //                     print(selectedId);
                    //                   });
                    //                 },
                    //                   value: selectedCategoryId,
                    //                   hint: Text('Select a category'),
                    //                 ),
                    //               selectedCategoryId != null
                    //                   ? Text('Selected category: ${apiResponse.data.firstWhere((category) => category.id == selectedCategoryId).category_name}')
                    //                   : SizedBox.shrink(),
                    //
                    //             ],
                    //           );
                    //     } else if (snapshot.hasError) {
                    //       print(snapshot.error);
                    //       return Center(
                    //         child: Column(
                    //           children: [
                    //             Lottie.network(
                    //               "https://assets3.lottiefiles.com/packages/lf20_JUr2Xt.json",
                    //               width: double.infinity,
                    //               fit: BoxFit.fill,
                    //             ),
                    //             Text(
                    //               'No Internet Connection',
                    //               style: TextStyle(fontSize: 22, color: Colors.red),
                    //             ),
                    //           ],
                    //         ),
                    //       );
                    //     }
                    //     return const Center(
                    //       child: CircularProgressIndicator(),
                    //     );
                    //   },
                    // ),
                    // End For Category Dropdown Code

                    // Start For Category Dropdown Testing Code
                    // For Category
                    Text("Category Name:", style: TextStyle(fontSize: 20)),
                    DropdownButton<int>(
                      isExpanded: true,
                      items: categoryList.map((category) {
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
                      hint: Text("Choose Category Name"),
                    ),
                    selectedCategoryId != null
                        ? Text('Selected category: ${categoryList.firstWhere((category) => category.id == selectedCategoryId).category_name}')
                        : SizedBox.shrink(),
                    SizedBox(height: 32),

                    // End For Category Dropdown Testing Code
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _submitForm,
                      child: _isLoading ? CircularProgressIndicator() : Text(
                          'Create SubCategory'),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
