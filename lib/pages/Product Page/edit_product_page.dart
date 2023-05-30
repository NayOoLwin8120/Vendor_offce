import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:vendor/Model/Brand%20Page%20Model%20/brand_model.dart';
import 'package:vendor/Model/Category%20Page%20Model%20/Sub_Category%20Page%20Model/sub_category_page_model.dart';
import 'package:vendor/Model/Category%20Page%20Model%20/category_page_model.dart';
import 'package:vendor/controllers/Brand%20Page%20Controller/brand_controller.dart';
import 'package:vendor/controllers/Category%20Page%20Controller/Sub_Category%20Page%20Controller/sub_category_page_controller.dart';
import 'package:vendor/controllers/Category%20Page%20Controller/category_page_controller.dart';
import 'package:vendor/controllers/Product%20Page%20Controller/product_page%20_controller.dart';

class EditProductPage extends StatefulWidget {
   int product_id;
  // String brand_name;
  String category_name;
  // String subcategory_name;
  // String product_name;
  // String product_code;
 //  int? product_qty;
 //  String? product_tags;
 //   String? product_size;
 //   String? product_color;
 //   int? selling_price;
 //   int? discount_price;
 //   String? short_descp;
 //   String? long_descp;
 //   int? hot_deals;
 //   int? featured;
 //   int? special_offer;
 // int? special_deals;
 // int? status;

  // String product_thambnail;



  EditProductPage({
    Key? key,
    required this.product_id,

    // required this.brand_name,
    required this.category_name,
    // required this.subcategory_name,
    // required this.product_name,
    // required this.product_code,
   //  int? this.discount_price,
   // int? this.product_qty,
   //  int? this.selling_price,
   //  String? this.product_color,
   //  String? this.long_descp,
   //  String? this.short_descp,
   // int? this.special_deals,
   //  int? this.special_offer,
   //  // required this.product_thambnail,
   //  int? this.hot_deals,
   //  String? this.product_size,
   //  int? this.status,
   // int? this.featured,
   //  String? this.product_tags,
  }) : super(key: key);

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final BrandApiController _brandApiController =BrandApiController();
  final CategoryApiController _categoryApiController = CategoryApiController();
  final SubCategoryApiController _subcategoryApiController=SubCategoryApiController();
  final ProductApiController  product=ProductApiController();


  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String _errorMessage = '';
  TextEditingController _ProductNameController = TextEditingController();
  TextEditingController _ProductCodeController = TextEditingController();
  TextEditingController _ProductTagsController = TextEditingController();
  TextEditingController _ProductSizeController = TextEditingController();
  TextEditingController _ProductQtyController = TextEditingController();
  TextEditingController _ProductColorController = TextEditingController();
  TextEditingController _SellingPriceController = TextEditingController();
  TextEditingController _DiscountPriceController = TextEditingController();
  TextEditingController _ShortDescpController = TextEditingController();
  TextEditingController _LongDescpController = TextEditingController();

  TextEditingController ProductQtyController = TextEditingController();

  int? selectedCategoryId;
  // int? selectedBrandId;
  // int? selectedSubCategoryId;
  String  categoryIdString='';

  // List<String> multiimg=[];
  // File? _singleImage;
  // String? statusValue;
  // int status = 1;
  // String? hotDealsValue;
  // int hotDealsStatus=1;
  // String? featuredValue;
  // int featuredStatus=1;
  // String? specialofferValue;
  // int specialofferStatus=1;
  // String? specialDealsValue;
  // int specialDealsStatus=1;// Default value is 1 for Active
  // String brandId='';
  // String categoryId='';
  // String subcategoryId='';
  String vendorId='';
  // String singleImageBase64='';



  final picker = ImagePicker();
  @override
  // void initState() {
  //   super.initState();
  //
  //    _ProductNameController.text = widget.product_name ?? "Choose Product Name";
  //   _ProductCodeController.text =  widget.product_code ?? "Choose Product Code";
  //   _ProductTagsController.text =  widget.product_tags ?? "Choose Tags";
  //   _ProductQtyController.text =  widget.product_qty?.toString() ?? "no";
  //   _ProductSizeController.text =  widget.product_size ?? "Choose Product Size";
  //   _ProductColorController.text =  widget.product_color ?? "Choose color";
  //   _SellingPriceController.text = widget.selling_price?.toString() ?? " ";
  //   _DiscountPriceController.text =  widget.discount_price?.toString() ?? " " ;
  //    _ShortDescpController.text =  widget.short_descp ?? "Choose Short Descp";
  //    _LongDescpController.text =  widget.long_descp ?? "Choose Long Descp";
  //
  // }
  void initState() {
    super.initState();

    // _ProductNameController.text = widget.product_name !;
    // _ProductCodeController.text = widget.product_code !;
    // _ProductTagsController.text = widget.product_tags != null ? widget.product_tags! : "";
    // _ProductQtyController.text = widget.product_qty != null ? widget.product_qty.toString() : "";
    // _ProductSizeController.text = widget.product_size != null ? widget.product_size! : "";
    // _ProductColorController.text = widget.product_color != null ? widget.product_color! : "";
    // _SellingPriceController.text = widget.selling_price != null ? widget.selling_price.toString() : "";
    // _DiscountPriceController.text = widget.discount_price != null ? widget.discount_price.toString() : "";
    // _ShortDescpController.text = widget.short_descp != null ? widget.short_descp! : "";
    // _LongDescpController.text = widget.long_descp != null ? widget.long_descp! : "";
  }

  // For getSingle Image Function
  // Future<void> _getSingleImage() async {
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //
  //   if (pickedFile != null) {
  //     setState(() {
  //       _singleImage = File(pickedFile.path);
  //     });
  //
  //   }
  //   if (_singleImage != null) {
  //     // Convert single image file to Base64
  //     List<int> singleImageBytes = await _singleImage!.readAsBytes();
  //     String singleImageBase = 'data:image/png;base64' + base64Encode(singleImageBytes);
  //     singleImageBase64=singleImageBase;
  //     print(singleImageBase64);
  //
  //   }
  // }
  // Future<void> _submitForm() async {
  //
  //   print("Your vendor id in product is $vendorId");
  //   brandId=selectedBrandId.toString();
  //   categoryId=selectedCategoryId.toString();
  //   subcategoryId=selectedSubCategoryId.toString();
  //   if (_formKey.currentState != null && _formKey.currentState!.validate()) {
  //
  //     try {
  //       print("data");
  //       setState(() {
  //         _isLoading = true;
  //         _errorMessage = '';
  //       });
  //       Options options = Options(
  //         headers: {
  //           'Content-Type': 'multipart/form-data',
  //         },
  //       );
  //       FormData formData = FormData();
  //
  //       if (_singleImage != null) {
  //         // Convert single image file to Base64
  //         List<int> singleImageBytes = await _singleImage!.readAsBytes();
  //         String singleImageBase64 = 'data:image/png;base64,' + base64Encode(singleImageBytes);
  //         // Get the file extension
  //         String extension = _singleImage!.path.split('.').last;
  //         formData.files.add(
  //           MapEntry(
  //             'product_thambnail',
  //             // MultipartFile.fromBytes(singleImageBytes,),
  //             MultipartFile.fromString(singleImageBase64),
  //           ),
  //         );
  //         // Create a FormData object to send multipart/form-data
  //
  //
  //       }
  //
  //       // Add the multi images to the FormData
  //
  //
  //
  //
  //       print('data2');
  //
  //       formData.fields.addAll(
  //           [
  //
  //             MapEntry('product_name' , _ProductNameController.text),
  //             MapEntry('product_code',_ProductCodeController.text),
  //             MapEntry('product_tags', _ProductTagsController.text),
  //             MapEntry('product_size', _ProductSizeController.text),
  //             MapEntry('product_color', _ProductColorController.text),
  //             MapEntry('selling_price', _SellingPriceController.text),
  //             MapEntry('discount_price', _DiscountPriceController.text),
  //             MapEntry( 'short_descp', _ShortDescpController.text),
  //             MapEntry('long_descp', _LongDescpController.text),
  //             MapEntry('hot_deals', hotDealsStatus.toString()),
  //             MapEntry('featured', featuredStatus.toString()),
  //             MapEntry('special_offer', specialofferStatus.toString()),
  //             MapEntry( 'special_deals', specialDealsStatus.toString()),
  //             MapEntry('product_qty', ProductQtyController.text),
  //             MapEntry('status', status.toString()),
  //             MapEntry('brand_id',brandId),
  //             MapEntry( 'category_id',categoryId),
  //             MapEntry( 'subcategory_id',subcategoryId),
  //             MapEntry('vendor_id', vendorId.toString()),
  //
  //           ]
  //       );
  //       int  id =widget.product_id!;
  //       // Make the POST request to the API
  //       Response response = await Dio().post(
  //         // 'https://ziizii.mickhae.com/api/vendor/product',
  //         'http://192.168.2.108:9999/api/vendor/product/$id',
  //         data: formData,
  //
  //         options: options,
  //       );
  //       print("data 3");
  //
  //       // Check the response status
  //       if (response.statusCode == 200) {
  //         print("ok");
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text('Category updated successfully!'),
  //             duration: Duration(seconds: 2),
  //           ),
  //         );
  //
  //         // Navigate to the brand list screen
  //         Navigator.pop(context);
  //
  //         // Handle the success scenario here
  //       } else {
  //         // Handle the failure scenario here
  //         setState(() {
  //           _errorMessage = 'Failed to send data to the API';
  //           print(_errorMessage);
  //         });
  //       }
  //     } catch (error) {
  //       // Handle any errors that occurred during the API request
  //       setState(() {
  //         _errorMessage = 'An error occurred: $error';
  //         print(_errorMessage);
  //       });
  //     } finally {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     }
  //   }
  // }

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
              children:
              [
                SizedBox(height: 16.0),
                FutureBuilder<String?>(
                  future:product.getVendorId(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error fetching vendor status');
                    } else {
                      String? vendorStatus = snapshot.data;
                      vendorId=vendorStatus.toString();
                      return Center(
                        child: Text(
                          "Create Product Form",
                          style: TextStyle(fontSize: 20,),
                        ),
                      );
                    }
                  },
                ),
                // for Product Name
                // TextFormField(
                //   controller: _ProductNameController,
                //   decoration: InputDecoration(labelText: 'Product Name',
                //     enabledBorder : OutlineInputBorder(
                //         borderSide: BorderSide(
                //           width: 3, //<-- SEE HERE
                //           color: Colors.blue,
                //         ),
                //         borderRadius: BorderRadius.circular(12.0)
                //     ),
                //   ),
                //
                //
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter the Product name';
                //     }
                //     return null;
                //   },
                // ),
                // SizedBox(height: 16.0),

                // for Product Tags
                // TextFormField(
                //   controller: _ProductTagsController,
                //   decoration: InputDecoration(labelText: 'Product Tags',enabledBorder : OutlineInputBorder(
                //       borderSide: BorderSide(
                //         width: 3, //<-- SEE HERE
                //         color: Colors.blue,
                //       ),
                //       borderRadius: BorderRadius.circular(12.0)
                //   ),),
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter the Product tags';
                //     }
                //     return null;
                //   },
                // ),
                // SizedBox(height: 16.0),

                // for Product Size
                // TextFormField(
                //   controller: _ProductSizeController,
                //   decoration: InputDecoration(labelText: 'Product Size',enabledBorder : OutlineInputBorder(
                //       borderSide: BorderSide(
                //         width: 3, //<-- SEE HERE
                //         color: Colors.blue,
                //       ),
                //       borderRadius: BorderRadius.circular(12.0)
                //   ),),
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter the Product Size';
                //     }
                //     return null;
                //   },
                // ),
                // SizedBox(height: 16.0),

                // for Product Color
                // TextFormField(
                //   controller: _ProductColorController,
                //   decoration: InputDecoration(labelText: 'Product Color',enabledBorder : OutlineInputBorder(
                //       borderSide: BorderSide(
                //         width: 3, //<-- SEE HERE
                //         color: Colors.blue,
                //       ),
                //       borderRadius: BorderRadius.circular(12.0)
                //   ),),
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter the Product Color name';
                //     }
                //     return null;
                //   },
                // ),
                // SizedBox(height: 16.0),

                Text("Vendor Main Image"),
               // if( widget.product_thambnail != null)
               //       Image.network(
               //    widget.product_thambnail!,
               //    width: 200,
               //    height: 200,
               //    fit: BoxFit.cover,
               //  )
               //      else
               //  ElevatedButton(
               //    onPressed: _getSingleImage,
               //    child: Text('Choose Product Single Image'),
               //  ),
               //  if (_singleImage != null)
               //    Image.file(
               //      _singleImage!,
               //      height: 200,
               //    ),

                // for Short Description
                // TextFormField(
                //   controller: _ShortDescpController,
                //   decoration: InputDecoration(labelText: 'Short Desciption',enabledBorder : OutlineInputBorder(
                //       borderSide: BorderSide(
                //         width: 3, //<-- SEE HERE
                //         color: Colors.blue,
                //       ),
                //       borderRadius: BorderRadius.circular(12.0)
                //   ),),
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter your Short Desciption';
                //     }
                //     return null;
                //   },
                // ),
                // SizedBox(height: 16.0),

                // for Long Description
                // TextFormField(
                //   controller: _LongDescpController,
                //   decoration: InputDecoration(labelText: 'Long Description',enabledBorder : OutlineInputBorder(
                //       borderSide: BorderSide(
                //         width: 3, //<-- SEE HERE
                //         color: Colors.blue,
                //       ),
                //       borderRadius: BorderRadius.circular(12.0)
                //   ),),
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter your Long Description';
                //     }
                //     return null;
                //   },
                // ),
                // SizedBox(height: 16.0),


                // if (widget.product_thambnail != null)
                //   Image.network(
                //     widget.product_thambnail!,
                //     width: 200,
                //     height: 200,
                //     fit: BoxFit.cover,
                //   ),
                //
                // // For Single Image
                // ElevatedButton(
                //   onPressed: _getSingleImage,
                //   child: Text('Choose Product Single Image'),
                // ),
                // if (_singleImage != null)
                //   Image.file(
                //     _singleImage!,
                //     height: 200,
                //   ),


                //For Multi Image
                // Multi Image Picker
                // ElevatedButton(
                //   onPressed: _getMultiImages,
                //   child: Text('Choose Product Multi Images'),
                // ),
                // SizedBox(height: 16.0),
                // if (_multiImages.isNotEmpty)
                //   Container(
                //
                //     height:200,
                //     child: ListView.builder(
                //       scrollDirection: Axis.horizontal,
                //       itemCount: _multiImages.length,
                //       itemBuilder: (BuildContext context, int index) {
                //         return Padding(
                //           padding: const EdgeInsets.all(20.0),
                //           child: Stack(
                //             clipBehavior: Clip.none,
                //             children: [
                //               Image.file(
                //                 _multiImages[index],
                //                 height: 70,
                //                 width: 100,
                //
                //               ),
                //               Positioned(
                //                 top:-15,
                //                 right: -15,
                //                 child: Container(
                //
                //                   width: 40,
                //                   height:40,
                //                   decoration:BoxDecoration(
                //                     color:Colors.white,
                //                     borderRadius: BorderRadius.circular(50),
                //                   ),
                //                   child: Center(
                //                     child: IconButton(
                //                       icon: Icon(Icons.close_sharp,color: Colors.black,size: 25,),
                //                       onPressed: () {
                //                         setState(() {
                //                           _multiImages.removeAt(index);
                //                         });
                //                       },
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           ),
                //         );
                //
                //
                //       },
                //     ),
                //   ),
                SizedBox(height:20),

                // for Selling Price
                // TextFormField(
                //   controller: _SellingPriceController,
                //   decoration: InputDecoration(labelText: 'Product Selling Price',enabledBorder : OutlineInputBorder(
                //       borderSide: BorderSide(
                //         width: 3, //<-- SEE HERE
                //         color: Colors.blue,
                //       ),
                //       borderRadius: BorderRadius.circular(12.0)
                //   ),),
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter the Product Selling Price';
                //     }
                //     return null;
                //   },
                // ),
                // SizedBox(height: 16.0),


                // for Discount Price
                // TextFormField(
                //   controller: _DiscountPriceController,
                //   decoration: InputDecoration(labelText: 'Product Discount Price',enabledBorder : OutlineInputBorder(
                //       borderSide: BorderSide(
                //         width: 3, //<-- SEE HERE
                //         color: Colors.blue,
                //       ),
                //       borderRadius: BorderRadius.circular(12.0)
                //   ),),
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter the Product Discount Price';
                //     }
                //     return null;
                //   },
                // ),
                // SizedBox(height: 16.0),


                // for Product Code
                // TextFormField(
                //   controller: _ProductCodeController,
                //   decoration: InputDecoration(labelText: 'Product Code',enabledBorder : OutlineInputBorder(
                //       borderSide: BorderSide(
                //         width: 3, //<-- SEE HERE
                //         color: Colors.blue,
                //       ),
                //       borderRadius: BorderRadius.circular(12.0)
                //   ),
                //   ),
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter the Product Code';
                //     }
                //     return null;
                //   },
                // ),
                // SizedBox(height: 16.0),


                // for Product Qty
                // TextFormField(
                //   controller: ProductQtyController,
                //   decoration: InputDecoration(labelText: 'Product Quantity',enabledBorder : OutlineInputBorder(
                //       borderSide: BorderSide(
                //         width: 3, //<-- SEE HERE
                //         color: Colors.blue,
                //       ),
                //       borderRadius: BorderRadius.circular(12.0)
                //   ),),
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter the Product Quantity';
                //     }
                //     return null;
                //   },
                // ),
                // SizedBox(height: 16.0),

                // _________for brand
                // Text("Brand Name :",style: TextStyle(fontSize: 16,color:Colors.black),),
                // FutureBuilder<BrandApiResponse>(
                //   future: _brandApiController.getData(),
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
                //         children: [
                //           DropdownButton<int>(
                //             isExpanded:true,
                //             items: apiResponse.data.map((brand) {
                //               return DropdownMenuItem<int>(
                //                 child: Text(brand.brand_name.toString()),
                //                 value: brand.id,
                //               );
                //             }).toList(),
                //             onChanged: (int? selectedId) {
                //               setState(() {
                //                 selectedBrandId = selectedId;
                //                 print(selectedId);
                //               });
                //             },
                //             value: selectedBrandId,
                //             hint: Text(widget.brand_name !=null ?  widget.brand_name : "Select a Brand  "),
                //           ),
                //           if (selectedBrandId != null && apiResponse.data.isNotEmpty)  // Check if the list is not empty
                //             Text('Selected Brand: ${apiResponse.data.firstWhere((brand) => brand.id == selectedBrandId).brand_name}'),
                //           // selectedBrandId != null
                //           //     ? Text('Selected Brand: ${apiResponse.data.firstWhere((brand) => brand.id == selectedCategoryId).brand_name}')
                //           //     : SizedBox.shrink(),
                //
                //         ],
                //       );
                //     } else if (snapshot.hasError) {
                //       print(snapshot.error);
                //       return Center(
                //         child: Column(
                //           children: [
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

                SizedBox(height: 30.0),

                // ___________ For Category
                // Text('Category Name:',style: TextStyle(fontSize: 16,color:Colors.black),),
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
                //         children: [
                //           DropdownButton<int>(
                //             isExpanded:true,
                //             items: apiResponse.data.map((category) {
                //               return DropdownMenuItem<int>(
                //                 child: Text(category.category_name.toString()),
                //                 value: category.id,
                //               );
                //             }).toList(),
                //             onChanged: (int? selectedId) {
                //               setState(() {
                //                 selectedCategoryId = selectedId;
                //                 print(selectedId);
                //               });
                //             },
                //             value: selectedCategoryId,
                //             hint: Text(widget.category_name!.isNotEmpty ? widget.category_name! : "Select a Category "),
                //           ),
                //           selectedCategoryId != null
                //               ? Text('Selected category: ${apiResponse.data.firstWhere((category) => category.id == selectedCategoryId).category_name}')
                //               : SizedBox.shrink(),
                //
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
                // SizedBox(height: 30.0),
                FutureBuilder<CategoryApiResponse>(
                  future: _categoryApiController.getData(),
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
                            hint:Text(widget.category_name),
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



                // ____________ For  SubCategory
                // Text("SubCategory Name :",style: TextStyle(fontSize: 16,color:Colors.black),),
                // FutureBuilder<SubCategoryApiResponse>(
                //   future: _subcategoryApiController.getData(),
                //   builder: (context, snapshot) {
                //     if (snapshot.hasData) {
                //       if (snapshot.connectionState == ConnectionState.waiting) {
                //         return Center(
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //
                //               Center(child: SizedBox(
                //                   width:10,
                //                   height:20,
                //                   child: CircularProgressIndicator())),
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
                //         children: [
                //           DropdownButton<int>(
                //             isExpanded:true,
                //             items: apiResponse.data.map((subcategory) {
                //               return DropdownMenuItem<int>(
                //                 child: Text(subcategory.subcategory_name.toString()),
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
                //             hint: Text(widget.subcategory_name!.isNotEmpty ? widget.subcategory_name! : 'Select a Subcategory'),
                //           ),
                //           selectedSubCategoryId != null
                //               ? Text('Selected Subcategory: ${apiResponse.data.firstWhere((subcategory) => subcategory.id == selectedCategoryId).subcategory_name}')
                //               : SizedBox.shrink(),
                //
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
                // SizedBox(height: 30.0),


                // For Status
                // Text("Choose Product Status :",style: TextStyle(fontSize: 16,color:Colors.black),),
                // DropdownButton<String>(
                //   isExpanded:true,
                //   hint: Text(widget.status == 1 ? "Active"  : 'Inactive'),
                //   value: statusValue,
                //   onChanged: (String? newValue) {
                //     setState(() {
                //       statusValue = newValue!;
                //       status = (newValue == 'Active') ? 1 : 0;
                //       print("Your status is $status");
                //     });
                //   },
                //   items: <String>['Active', 'Inactive'].map<DropdownMenuItem<String>>((String value) {
                //     return DropdownMenuItem<String>(
                //       value: value,
                //       child: Text(value),
                //     );
                //   }).toList(),
                //
                // ),
                SizedBox(height: 30.0),

                //For HotDeals
                // Text("Choose Product Status Hot Deals :",style: TextStyle(fontSize: 16,color:Colors.black),),
                // DropdownButton<String>(
                //   isExpanded:true,
                //   hint: Text(widget.hot_deals == 1 ? "Yes"  : 'No'),
                //   value: hotDealsValue,
                //   onChanged: (String? newValue) {
                //     setState(() {
                //       hotDealsValue = newValue!;
                //       hotDealsStatus= (newValue == 'Yes') ? 1 : 0;
                //       print("Your status is $status");
                //     });
                //   },
                //   items: <String>['Yes','No'].map<DropdownMenuItem<String>>((String value) {
                //     return DropdownMenuItem<String>(
                //       value: value,
                //       child: Text(value),
                //     );
                //   }).toList(),
                //
                // ),
                SizedBox(height: 30.0),

                //For Featured
                // Text("Choose Product Status Featured :",style: TextStyle(fontSize: 16,color:Colors.black),),
                // DropdownButton<String>(
                //   isExpanded:true,
                //   hint: Text(widget.featured == 1 ? "Yes"  : 'No'),
                //   value:featuredValue,
                //   onChanged: (String? newValue) {
                //     setState(() {
                //       featuredValue = newValue!;
                //       specialDealsStatus= (newValue == 'Yes') ? 1 : 0;
                //       print("Your status is $status");
                //     });
                //   },
                //   items: <String>['Yes', 'No'].map<DropdownMenuItem<String>>((String value) {
                //     return DropdownMenuItem<String>(
                //       value: value,
                //       child: Text(value),
                //     );
                //   }).toList(),
                //
                // ),
                SizedBox(height: 30.0),

                // For Special Offers
                // Text("Choose Product Status Special Offers :",style: TextStyle(fontSize: 16,color:Colors.black),),
                // DropdownButton<String>(
                //   isExpanded:true,
                //   hint: Text( widget.special_offer == 1 ? "Yes"  : 'No'),
                //   value: specialofferValue,
                //   onChanged: (String? newValue) {
                //     setState(() {
                //       specialofferValue = newValue!;
                //       specialofferStatus = (newValue == 'Yes') ? 1 : 0;
                //       print("Your status is $status");
                //     });
                //   },
                //   items: <String>['Yes', 'No'].map<DropdownMenuItem<String>>((String value) {
                //     return DropdownMenuItem<String>(
                //       value: value,
                //       child: Text(value),
                //     );
                //   }).toList(),
                //
                // ),
                SizedBox(height: 30.0),

                // For Special Deals
                // Text("Choose Product Status Special Deals :",style: TextStyle(fontSize: 16,color:Colors.black),),
                //
                // DropdownButton<String>(
                //   isExpanded:true,
                //   hint: Text(widget.special_deals == 1 ? "Yes"  : 'No'),
                //   value: specialDealsValue,
                //   onChanged: (String? newValue) {
                //     setState(() {
                //       specialDealsValue = newValue!;
                //       specialDealsStatus = (newValue == 'Yes') ? 1 : 0;
                //       print("Your status is $status");
                //     });
                //   },
                //   items: <String>['Yes', 'No'].map<DropdownMenuItem<String>>((String value) {
                //     return DropdownMenuItem<String>(
                //       value: value,
                //       child: Text(value),
                //     );
                //   }).toList(),
                //
                // ),
                SizedBox(height: 30.0),


                // ElevatedButton(
                //   onPressed: _isLoading ? null : _submitForm,
                //   child: _isLoading ? CircularProgressIndicator() : Text(
                //       'Create Product'),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
