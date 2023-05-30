import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:vendor/Model/Category%20Page%20Model%20/category_page_model.dart';
import 'package:vendor/controllers/Brand%20Page%20Controller/brand_controller.dart';
import 'package:vendor/controllers/Category%20Page%20Controller/Sub_Category%20Page%20Controller/sub_category_page_controller.dart';
import 'package:vendor/controllers/Product%20Page%20Controller/product_page%20_controller.dart';
import 'package:vendor/pages/Product%20Page/product.dart';

import '../../Model/Brand Page Model /brand_model.dart';
import '../../Model/Category Page Model /Sub_Category Page Model/sub_category_page_model.dart';
import '../../controllers/Category Page Controller/category_page_controller.dart';

class CreateProduct extends StatefulWidget {
  const CreateProduct({Key? key}) : super(key: key);

  @override
  State<CreateProduct> createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  final _brandApiController = BrandApiController();
  final _categoryApiController = CategoryApiController();
  final _subcategoryApiController = SubCategoryApiController();
  final ProductApiController product = ProductApiController();

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String _errorMessage = '';
  TextEditingController _ProductNameController = TextEditingController();
  TextEditingController _ProductCodeController = TextEditingController();
  TextEditingController _ProductTagsController = TextEditingController();
  TextEditingController _ProductSizeController = TextEditingController();
  TextEditingController _ProductColorController = TextEditingController();
  TextEditingController _SellingPriceController = TextEditingController();
  TextEditingController _DiscountPriceController = TextEditingController();
  TextEditingController _ShortDescpController = TextEditingController();
  TextEditingController _LongDescpController = TextEditingController();

  TextEditingController ProductQtyController = TextEditingController();

  int? selectedCategoryId;
  String? selectedname;
  int? selectedBrandId;
  int? selectedSubCategoryId;
  String categoryIdString = '';
  List<File> _multiImages = [];
  List<String> multiimg = [];
  File? _singleImage;
  String? statusValue;
  int status = 1;
  String? hotDealsValue;
  int hotDealsStatus = 1;
  String? featuredValue;
  int featuredStatus = 1;
  String? specialofferValue;
  int specialofferStatus = 1;
  String? specialDealsValue;
  int specialDealsStatus = 1; // Default value is 1 for Active
  String brandId = '';
  String categoryId = '';
  String subcategoryId = '';
  String vendorId = '';
  String singleImageBase64 = '';
  List<String> imageBase64List = [];

  List<String> productTags = [];
  List<String> productSize = [];
  List<String> productColor = [];
  List<Data> categoryList = [];
  List<Datasubcategory> subcategoryList = [];
  List<Databrand> brandList = [];
  int sellingprice=1;
  int discountprice=1;




  // Start For Category , Brand ,Subcategory dropdown Code Testing
   // Replace "Brand" with your actual data model
  // End For Category , Brand ,Subcategory dropdown Code Testing

  final picker = ImagePicker();




  void _addProductTag() {
    String tag = _ProductTagsController.text.trim();
    if (tag.isNotEmpty) {
      setState(() {
        productTags.add(tag);
      });
      _ProductTagsController.clear();
    }
  }

  void _removeProductTag(String tag) {
    setState(() {
      productTags.remove(tag);
    });
  }

  void _addProductSize() {
    String size = _ProductSizeController.text.trim();
    if (size.isNotEmpty) {
      setState(() {
        productSize.add(size);
      });
      _ProductSizeController.clear();
    }
  }

  void _removeProductSize(String size) {
    setState(() {
      productSize.remove(size);
    });
  }

  void _addProductColor() {
    String color = _ProductColorController.text.trim();
    if (color.isNotEmpty) {
      setState(() {
        productColor.add(color);
      });
      _ProductColorController.clear();
    }
  }

  void _removeProductColor(String color) {
    setState(() {
      productColor.remove(color);
    });
  }

  // For getSingle Image Function

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
          'data:image/jpeg;base64,' + base64Encode(singleImageBytes);
      singleImageBase64 = singleImageBase;
      print(singleImageBase64);
    }
  }

  // For Multi Image Function
  Future<void> _getMultiImages() async {
    final pickedFiles = await ImagePicker().pickMultiImage();

    if (pickedFiles != null) {
      setState(() {
        _multiImages =
            pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
      });
      for (File image  in _multiImages){
        List<int> imageBytes = await image.readAsBytes();
        String imageBase64 =
            'data:image/png;base64,' + base64Encode(imageBytes);

        imageBase64List.add(imageBase64);
        print(imageBase64List);
      }
    }
  }

  Future<void> _submitForm() async {
    print("Your vendor id in product is $vendorId");
    brandId = selectedBrandId.toString();
    categoryId = selectedCategoryId.toString();
    subcategoryId = selectedSubCategoryId.toString();
    sellingprice=int.parse(_SellingPriceController.text);
    discountprice=int.parse(_DiscountPriceController.text);


    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      try {
        print("data");
        setState(() {
          _isLoading = true;
          _errorMessage = '';
        });
        Options options = Options(
          // followRedirects: true,
          headers: {
            'Content-Type': 'application/json',
            // Modify the content type if needed
            // 'Content-Type': 'multipart/form-data',
             // Include the authorization header if required
          },
        );
        // Options options = Options(
        //   followRedirects: true,
        //   headers: {
        //     'Content-Type': 'multipart/form-data',
        //   },
        // );
        // FormData formData = FormData();

        // if (_singleImage != null) {
        //   // Convert single image file to Base64
        //   List<int> singleImageBytes = await _singleImage!.readAsBytes();
        //   String singleImageBase64 =
        //       'data:image/png;base64,' + base64Encode(singleImageBytes);
        //   // Get the file extension
        //   String extension = _singleImage!.path.split('.').last;
        //   formData.files.add(
        //     MapEntry(
        //       'product_thambnail',
        //       // MultipartFile.fromBytes(singleImageBytes,),
        //       MultipartFile.fromString(singleImageBase64),
        //     ),
        //   );
        //   // Create a FormData object to send multipart/form-data
        // }

        // Add the multi images to the FormData

        // for (File image in _multiImages) {
        //   // Convert each image file to Base64
        //   List<int> imageBytes = await image.readAsBytes();
        //   String imageBase64 =
        //       'data:image/png;base64,' + base64Encode(imageBytes);
        //   // multiimg.add(imageBase64);
        //   // print(multiimg);
        //
        //   formData.files.add(
        //     MapEntry(
        //       'multi_img[]',
        //       MultipartFile.fromString(imageBase64),
        //     ),
        //   );
        // }
        // formData.fields.add(MapEntry(
        //   'multi_img',
        //   imageBase64,
        // ));

        // print('data2');

        // formData.fields.addAll([
        //   MapEntry('product_name', _ProductNameController.text),
        //   MapEntry('product_code', _ProductCodeController.text),
        //   MapEntry('product_tags[]', productTags.join(',')),
        //   MapEntry('product_size[]', productSize.join(",")),
        //   MapEntry('product_color[]', productColor.join(",")),
        //   MapEntry('selling_price', sellingprice.toString()),
        //   MapEntry('discount_price', _DiscountPriceController.text),
        //   MapEntry('short_descp', _ShortDescpController.text),
        //   MapEntry('long_descp', _LongDescpController.text),
        //   MapEntry('hot_deals', hotDealsStatus.toString()),
        //   MapEntry('featured', featuredStatus.toString()),
        //   MapEntry('special_offer', specialofferStatus.toString()),
        //   MapEntry('special_deals', specialDealsStatus.toString()),
        //   MapEntry('product_qty', ProductQtyController.text),
        //   MapEntry('status', status.toString()),
        //   MapEntry('brand_id', brandId),
        //   MapEntry('category_id', categoryId),
        //   MapEntry('subcategory_id', subcategoryId),
        //   MapEntry('vendor_id', vendorId.toString()),
        // ]);
        // Make the POST request to the API
        Response response = await Dio().post(
          // 'https://ziizii.mickhae.com/api/vendor/product',
          'https://ziizii.mickhae.com/api/vendor/product',
          // data: formData,
          data: {
            'product_name': _ProductNameController.text,
           'product_code': _ProductCodeController.text,
            'product_tags': productTags,
            'product_size':productSize,
          'product_color': productColor,
            'selling_price': sellingprice,
          'discount_price':discountprice,
            'short_descp': _ShortDescpController.text,
            'long_descp': _LongDescpController.text,
            'hot_deals': hotDealsStatus.toString(),
            'featured': featuredStatus.toString(),
           'special_offer': specialofferStatus.toString(),
            'special_deals':specialDealsStatus.toString(),
         'product_qty': ProductQtyController.text,
        'status': status.toString(),
            'brand_id': brandId,
            'category_id': categoryId,
           'subcategory_id': subcategoryId,
            'vendor_id': vendorId.toString(),
            'product_thambnail':singleImageBase64,
            'multi_images':imageBase64List,
          },
          options: options,
        );
        print("data 3");

        // Check the response status
        if (response.statusCode == 200) {
          print("ok");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Category updated successfully!'),
              duration: Duration(seconds: 2),
            ),
          );

          // Navigate to the brand list screen
          // Navigator.of(context).pushReplacement(
          //     MaterialPageRoute(builder: (context) => Product()
          //     ));
          Navigator.pop(context);
          ProductApiController().getData();


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
    // TODO: implement initState
    super.initState();
    _categoryApiController.getData().then((response) {
      setState(() {
        categoryList = response.data;
      });
    });
    _brandApiController.getData().then((response) {
      setState(() {

        brandList = response.data;
      });
    });



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Product'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 16.0),
                FutureBuilder<String?>(
                  future: product.getVendorId(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error fetching vendor status');
                    } else {
                      String? vendorStatus = snapshot.data;
                      vendorId = vendorStatus.toString();
                      return Center(
                        child: Text(
                          "Create Product Form",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      );
                    }
                  },
                ),
                // for Product Name
                TextFormField(
                  controller: _ProductNameController,
                  decoration: InputDecoration(
                    labelText: 'Product Name',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 3, //<-- SEE HERE
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(12.0)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the Product name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),

                // For Product Tags
                TextField(
                  controller: _ProductTagsController,
                  onSubmitted: (_) => _addProductTag(),
                  decoration: InputDecoration(
                    labelText: 'Product Tags',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: _addProductTag,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: productTags.map((tag) {
                    return Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              tag,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.cancel,
                              color: Colors.white,
                            ),
                            onPressed: () => _removeProductTag(tag),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 32.0),

                //For Product Size
                TextField(
                  controller: _ProductSizeController,
                  onSubmitted: (_) => _addProductSize(),
                  decoration: InputDecoration(
                    labelText: 'Product Size',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: _addProductSize,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: productSize.map((tag) {
                    return Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              tag,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.cancel,
                              color: Colors.white,
                            ),
                            onPressed: () => _removeProductSize(tag),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 32.0),

                // For Product Color
                TextField(
                  controller: _ProductColorController,
                  onSubmitted: (_) => _addProductColor(),
                  decoration: InputDecoration(
                    labelText: 'Product Color',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: _addProductColor,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: productColor.map((tag) {
                    return Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              tag,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.cancel,
                              color: Colors.white,
                            ),
                            onPressed: () => _removeProductColor(tag),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 32.0),

                // for Short Description
                TextFormField(
                  controller: _ShortDescpController,
                  decoration: InputDecoration(
                    labelText: 'Short Desciption',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 3, //<-- SEE HERE
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(12.0)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Short Desciption';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),

                // for Long Description
                TextFormField(
                  controller: _LongDescpController,
                  decoration: InputDecoration(
                    labelText: 'Long Description',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 3, //<-- SEE HERE
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(12.0)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Long Description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),

                // For Single Image
                ElevatedButton(
                  onPressed: _getSingleImage,
                  child: Text('Choose Product Single Image'),
                ),
                if (_singleImage != null)
                  Image.file(
                    _singleImage!,
                    height: 200,
                  ),
                SizedBox(height: 16.0),

                //For Multi Image
                // Multi Image Picker
                ElevatedButton(
                  onPressed: _getMultiImages,
                  child: Text('Choose Product Multi Images'),
                ),
                SizedBox(height: 16.0),
                if (_multiImages.isNotEmpty)
                  Container(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _multiImages.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Image.file(
                                _multiImages[index],
                                height: 70,
                                width: 100,
                              ),
                              Positioned(
                                top: -15,
                                right: -15,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Center(
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.close_sharp,
                                        color: Colors.black,
                                        size: 25,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _multiImages.removeAt(index);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                SizedBox(height: 20),

                // for Selling Price
                TextFormField(
                  controller: _SellingPriceController,
                  decoration: InputDecoration(
                    labelText: 'Product Selling Price',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 3, //<-- SEE HERE
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(12.0)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the Product Selling Price';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),

                // for Discount Price
                TextFormField(
                  controller: _DiscountPriceController,
                  decoration: InputDecoration(
                    labelText: 'Product Discount Price',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 3, //<-- SEE HERE
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(12.0)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the Product Discount Price';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),

                // for Product Code
                TextFormField(
                  controller: _ProductCodeController,
                  decoration: InputDecoration(
                    labelText: 'Product Code',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 3, //<-- SEE HERE
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(12.0)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the Product Code';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),

                // for Product Qty
                TextFormField(
                  controller: ProductQtyController,
                  decoration: InputDecoration(
                    labelText: 'Product Quantity',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 3, //<-- SEE HERE
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(12.0)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the Product Quantity';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),

                // _________for brand
                Text(
                  "Brand Name :",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                // Builder(
                //   builder: (BuildContext brandContext) {
                //     return FutureBuilder<BrandApiResponse>(
                //       future: _brandApiController.getData(),
                //       builder: (context, snapshot) {
                //         if (snapshot.hasData) {
                //           if (snapshot.connectionState == ConnectionState.waiting) {
                //             return Center(
                //               child: Column(
                //                 mainAxisAlignment: MainAxisAlignment.center,
                //                 children: [
                //                   Center(child: Text("Data are Loading")),
                //                   Center(child: CircularProgressIndicator()),
                //                 ],
                //               ),
                //             );
                //           }
                //           if (snapshot.hasError) {
                //             return Center(child: Text('Error fetching data'));
                //           }
                //           final apiResponse = snapshot.data!;
                //
                //           return Column(
                //             children: [
                //               DropdownButton<int>(
                //                 isExpanded: true,
                //                 // items: apiResponse.data.map((brand) {
                //                 //   return DropdownMenuItem<int>(
                //                 //     child: Text(brand.brand_name.toString()),
                //                 //     value: brand.id,
                //                 //   );
                //                   items: brandList.map((brand) {
                //                   return DropdownMenuItem<int>(
                //                   child: Text(brand.brand_name.toString()),
                //                   value: brand.id,
                //                   );
                //                 }).toList(),
                //                 onChanged: (int? selectedId) {
                //                   setState(() {
                //                     selectedBrandId = selectedId;
                //                     print(selectedId);
                //                   });
                //                 },
                //                 value: selectedBrandId,
                //                 hint: Text('Select a Brand'),
                //               ),
                //               if (selectedBrandId != null &&
                //                   apiResponse.data
                //                       .isNotEmpty) // Check if the list is not empty
                //                 Text(
                //                     'Selected Brand: ${apiResponse.data.firstWhere((brand) => brand.id == selectedBrandId).brand_name}'),
                //               // selectedBrandId != null
                //               //     ? Text('Selected Brand: ${apiResponse.data.firstWhere((brand) => brand.id == selectedCategoryId).brand_name}')
                //               //     : SizedBox.shrink(),
                //             ],
                //           );
                //         } else if (snapshot.hasError) {
                //           print(snapshot.error);
                //           return Center(
                //             child: Column(
                //               children: [
                //                 Text(
                //                   'No Internet Connection',
                //                   style: TextStyle(fontSize: 22, color: Colors.red),
                //                 ),
                //               ],
                //             ),
                //           );
                //         }
                //         return const Center(
                //           child: CircularProgressIndicator(),
                //         );
                //       },
                //     );
                //   }
                // ),

                DropdownButton<int>(
                  isExpanded: true,
                  items: brandList.map((brand) {
                    return DropdownMenuItem<int>(
                      child: Text(brand.brand_name.toString()),
                      value: brand.id,
                    );
                  }).toList(),
                  onChanged: (int? selectedId) {
                    setState(() {
                      selectedBrandId=selectedId;
                      print(selectedBrandId);
                    });
                  },
                  value: selectedBrandId,
                  hint: Text('Select a Brand'),
                ),

                SizedBox(height: 30.0),

                // ___________ For Category
                // Text(
                //   'Category Name:',
                //   style: TextStyle(fontSize: 16, color: Colors.black),
                // ),
                // Builder(
                //   builder: (BuildContext categoryContext) {
                //     return FutureBuilder<CategoryApiResponse>(
                //       future: _categoryApiController.getData(),
                //       builder: (context, snapshot) {
                //         if (snapshot.hasData) {
                //           if (snapshot.connectionState == ConnectionState.waiting) {
                //             return Center(
                //               child: Column(
                //                 mainAxisAlignment: MainAxisAlignment.center,
                //                 children: [
                //                   Center(child: Text("Data are Loading")),
                //                   Center(child: CircularProgressIndicator()),
                //                 ],
                //               ),
                //             );
                //           }
                //           if (snapshot.hasError) {
                //             return Center(child: Text('Error fetching data'));
                //           }
                //           final apiResponse = snapshot.data!;
                //
                //           return Column(
                //             children: [
                //               DropdownButton<int>(
                //                 isExpanded: true,
                //                 // items: apiResponse.data.map((category) {
                //                 //   return DropdownMenuItem<int>(
                //                 //     child: Text(category.category_name.toString()),
                //                 //     value: category.id,
                //                 //   );
                //                 // }).toList(),
                //                 items: categoryList.map((category) {
                //                   return DropdownMenuItem<int>(
                //                     child: Text(category.category_name.toString()),
                //                     value: category.id,
                //                   );
                //                 }).toList(),
                //                 onChanged: (int? selectedId) {
                //                   setState(() {
                //                     selectedCategoryId = selectedId;
                //                     if (selectedCategoryId != null) {
                //                       selectedname = apiResponse.data
                //                           .firstWhere((category) =>
                //                               category.id == selectedCategoryId)
                //                           .category_name;
                //                     }
                //                     selectedSubCategoryId = null; // Reset the selected subcategory
                //
                //                     print(selectedname);
                //                     print(selectedId);
                //                   });
                //                 },
                //                 value: selectedCategoryId,
                //                 hint: Text('Select a category'),
                //               ),
                //               selectedCategoryId != null
                //                   ? Text(
                //                       'Selected category: ${apiResponse.data.firstWhere((category) => category.id == selectedCategoryId).category_name}')
                //                   : SizedBox.shrink(),
                //             ],
                //           );
                //         } else if (snapshot.hasError) {
                //           print(snapshot.error);
                //           return Center(
                //             child: Column(
                //               children: [
                //                 Lottie.network(
                //                   "https://assets3.lottiefiles.com/packages/lf20_JUr2Xt.json",
                //                   width: double.infinity,
                //                   fit: BoxFit.fill,
                //                 ),
                //                 Text(
                //                   'No Internet Connection',
                //                   style: TextStyle(fontSize: 22, color: Colors.red),
                //                 ),
                //               ],
                //             ),
                //           );
                //         }
                //         return const Center(
                //           child: CircularProgressIndicator(),
                //         );
                //       },
                //     );
                //   }
                // ),
                Text(
                  "Category Name:",
                  style: TextStyle(fontSize: 20),
                ),
                DropdownButton<int>(
                  isExpanded: true,
                  items:categoryList.map((category) {
                    return DropdownMenuItem<int>(
                      child: Text(category.category_name.toString()),
                      value: category.id,
                    );
                  }).toList(),
                  onChanged: (int? selectedId) {
                    setState(() {
                      selectedCategoryId = selectedId;
                                          if (selectedCategoryId != null) {
                                            selectedname = categoryList
                                                .firstWhere((category) =>
                                                    category.id == selectedCategoryId)
                                                .category_name;
                                          }
                      print(selectedId);
                    });
                  },
                  value: selectedCategoryId,
                  hint: Text('Select a Category'),
                ),
                selectedCategoryId != null
                    ? Text('Selected Category: ${categoryList.firstWhere((category) => category.id == selectedCategoryId).category_name}')
                    : SizedBox.shrink(),


                SizedBox(height: 30.0),
                // ____________ For  SubCategory
                // Text(
                //   "SubCategory Name :",
                //   style: TextStyle(fontSize: 16, color: Colors.black),
                // ),
                // FutureBuilder<SubCategoryApiResponse>(
                //   future: _subcategoryApiController.getData(),
                //   builder: (context, snapshot) {
                //     if (snapshot.hasData) {
                //       if (snapshot.connectionState == ConnectionState.waiting) {
                //         return Center(
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               Center(
                //                   child: SizedBox(
                //                       width: 10,
                //                       height: 20,
                //                       child: CircularProgressIndicator())),
                //             ],
                //           ),
                //         );
                //       }
                //       if (snapshot.hasError) {
                //         return Center(child: Text('Error fetching data'));
                //       }
                //       final apiResponse = snapshot.data!;
                //
                //       final filteredSubcategories = apiResponse.data
                //           .where((subcategory) =>
                //               subcategory.category == selectedname)
                //           .toList();
                //
                //       return Column(
                //         children: [
                //           DropdownButton<int>(
                //             isExpanded: true,
                //             // items: apiResponse.data.map((subcategory) {
                //             //   return DropdownMenuItem<int>(
                //             //     child: Text(subcategory.subcategory_name.toString()),
                //             //     value: subcategory.id,
                //             //   );
                //             items: filteredSubcategories.map((subcategory) {
                //               return DropdownMenuItem<int>(
                //                 child: Text(
                //                     subcategory.subcategory_name.toString()),
                //                 value: subcategory.id,
                //               );
                //             }).toList(),
                //             onChanged: (int? selectedId) {
                //               setState(() {
                //                 selectedSubCategoryId = selectedId;
                //                 print(selectedId);
                //               });
                //             },
                //             value: selectedSubCategoryId,
                //             hint: Text('Select a Subcategory'),
                //           ),
                //           selectedSubCategoryId != null
                //               ? Text(
                //                   'Selected Subcategory: ${apiResponse.data.firstWhere((subcategory) => subcategory.id == selectedCategoryId).subcategory_name}')
                //               : SizedBox.shrink(),
                //         ],
                //       );
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
                Text(
                  "SubCategory Name :",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                Builder(
                  builder: (BuildContext subcategoryContext) {
                    return FutureBuilder<SubCategoryApiResponse>(
                      future: _subcategoryApiController.getData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: SizedBox(
                                      width: 10,
                                      height: 20,
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          if (snapshot.hasError) {
                            return Center(child: Text('Error fetching data'));
                          }
                          final apiResponse = snapshot.data!;

                          // final filteredSubcategories = apiResponse.data
                          //     .where((subcategory) => subcategory.category == selectedname)
                          //     .toList();
                          List<Datasubcategory> filteredSubcategories = [];
                          if (selectedname != null) {
                            filteredSubcategories = apiResponse.data
                                .where((subcategory) => subcategory.category == selectedname)
                                .toList();
                          }






                          Widget buildSubCategoryDropdown(List<Datasubcategory> subcategories, int? selectedId) {

                            String selectedSubcategoryName = '';



                            return DropdownButton<int>(
                              isExpanded: true,
                              items:filteredSubcategories.map((subcategory) {
                                return DropdownMenuItem<int>(
                                  child: Text(subcategory.subcategory_name.toString()),
                                  value: subcategory.id,
                                );
                              }).toList(),
                              onChanged: (int? selectedId) {
                                setState(() {
                                  selectedSubCategoryId = selectedId;
                                  selectedSubcategoryName = filteredSubcategories.firstWhere((subcategory) => subcategory.id == selectedId).subcategory_name!;
                                  print(selectedId);
                                  print(selectedSubcategoryName);
                                });
                              },
                              value: selectedSubCategoryId,
                              hint: Text('Select a Subcategory'),
                            );
                          }

                          return Column(
                            children: [
                              buildSubCategoryDropdown(filteredSubcategories, selectedSubCategoryId),
                              selectedSubCategoryId != null
                                  ? Text(
                                  'Selected Subcategory: ${filteredSubcategories.firstWhere((subcategory) => subcategory.id == selectedSubCategoryId).subcategory_name}')
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
                    );
                  }
                ),








                SizedBox(height: 30.0),

                // For Status
                Text(
                  "Choose Product Status :",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                DropdownButton<String>(
                  isExpanded: true,
                  hint: Text('Choose Product Status '),
                  value: statusValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      statusValue = newValue!;
                      status = (newValue == 'Active') ? 1 : 0;
                      print("Your status is $status");
                    });
                  },
                  items: <String>['Active', 'Inactive']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 30.0),

                //For HotDeals
                Text(
                  "Choose Product Status Hot Deals :",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                DropdownButton<String>(
                  isExpanded: true,
                  hint: Text('Choose HotDeals Status '),
                  value: hotDealsValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      hotDealsValue = newValue!;
                      hotDealsStatus = (newValue == 'Yes') ? 1 : 0;
                      print("Your status is $status");
                    });
                  },
                  items: <String>['Yes', 'No']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 30.0),

                //For Featured
                Text(
                  "Choose Product Status Featured :",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                DropdownButton<String>(
                  isExpanded: true,
                  hint: Text('Choose Product Featured Status'),
                  value: featuredValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      featuredValue = newValue!;
                      specialDealsStatus = (newValue == 'Yes') ? 1 : 0;
                      print("Your status is $status");
                    });
                  },
                  items: <String>['Yes', 'No']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 30.0),

                // For Special Offers
                Text(
                  "Choose Product Status Special Offers :",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                DropdownButton<String>(
                  isExpanded: true,
                  hint: Text('Choose Product Special Offers : '),
                  value: specialofferValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      specialofferValue = newValue!;
                      specialofferStatus = (newValue == 'Yes') ? 1 : 0;
                      print("Your status is $status");
                    });
                  },
                  items: <String>['Yes', 'No']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 30.0),

                // For Special Deals
                Text(
                  "Choose Product Status Special Deals :",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                DropdownButton<String>(
                  isExpanded: true,
                  hint: Text('Choose Product Special Deals Status '),
                  value: specialDealsValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      specialDealsValue = newValue!;
                      specialDealsStatus = (newValue == 'Yes') ? 1 : 0;
                      print("Your status is $status");
                    });
                  },
                  items: <String>['Yes', 'No']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 30.0),

                ElevatedButton(
                  onPressed: _isLoading ? null : _submitForm,
                  child: _isLoading
                      ? CircularProgressIndicator()
                      : Text('Create Product'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
