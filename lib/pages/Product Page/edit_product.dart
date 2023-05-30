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

class Editpage extends StatefulWidget {
  int id;
  String categoryname;
  String productname;
  String subcategoryname;
  String? brandname;
  // String? product_tags;
   List<String?>? productTags;
  String? product_code;
  int? product_qty;
  // String? product_size;
  List<String?>? product_size;
  // String? product_color;
  List<String?>? product_color;
  int? selling_price;
  int? discount_price;
  String? short_descp;
  String? long_descp;
  int? hot_deals;
  int? featured;
  int? special_offer;
  int? special_deals;
  int? status;
  int? vendor_id;
  String? product_thambial;
  bool _isImageSelected=false;
   List<String?>? multiimageList;

   Editpage({
     required this.id,
     required this.categoryname,
     required this.productname,
     required this.subcategoryname,
     this.brandname,
     this.productTags,
     this.product_code,
     this.product_qty,
     this.product_size,
     this.short_descp,
     this.long_descp,
     this.product_color,
     this.selling_price,
     this.discount_price,
     this.featured,
     this.status,
     this.hot_deals,
     this.special_offer,
     this.special_deals,
     this.vendor_id,
     this.product_thambial,
      this.multiimageList,
     Key? key}) : super(key: key);

  @override
  State<Editpage> createState() => _EditpageState();
}

class _EditpageState extends State<Editpage> {

  final CategoryApiController _category=CategoryApiController();
  final SubCategoryApiController _subcategory=SubCategoryApiController();
  final BrandApiController _brand=BrandApiController();
  final ProductApiController _product=ProductApiController();

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String _errorMessage = '';
  final _productNameController = TextEditingController();
  final _productTagsController=TextEditingController();
  final _productCodeController=TextEditingController();
  final _productQtyController=TextEditingController();
  final _productSizeController=TextEditingController();
  final _productColorController=TextEditingController();
  final _sellingPriceController=TextEditingController();
  final _discountPriceController=TextEditingController();
  final _shortDescpController=TextEditingController();
  final _longDescpController=TextEditingController();
  final picker=ImagePicker();


  int? selectedCategoryId;
  String  categoryIdString='';
  int? selectedSubcategoryId;
  String SubCategoryString='';
  int? selectedbrandId;
  String brandString='';
  String productqtyString='';
  List<String?> productTags = [];
  List<String?> productSize = [];
  List<String?> productColor = [];
  String? statusValue;
  int? status ;
  String? hotDealsValue;
  int? hotDealsStatus;
  String? featuredValue;
  int? featuredStatus=1;
  String? specialofferValue;
  int? specialofferStatus;
  String? specialDealsValue;
  int? specialDealsStatus;
  File? _singleImage;
  String singleImageBase64='';
  int? sellingprice;
  int? discountprice;
  List<File> _multiImages = [];
  List<String> imageBase64List = [];

  @override
  void initState() {
    super.initState();
    _productNameController.text = widget.productname!;
    productTags=widget.productTags!;

    _productCodeController.text=widget.product_code!;
    _productQtyController.text=widget.product_qty!.toString();

    productSize=widget.product_size!;

    productColor=widget.product_color!;

    _sellingPriceController.text=widget.selling_price!.toString();
    _discountPriceController.text=widget.discount_price!.toString();
    _shortDescpController.text=widget.short_descp!;
    _longDescpController.text=widget.long_descp!;

  }
  void _addProductTag() {
    String tag = _productTagsController.text.trim();
    if (tag.isNotEmpty) {
      setState(() {
        productTags.add(tag);
      });
      _productTagsController.clear();
    }
  }
  void _removeProductTag(String tag) {
    setState(() {
      productTags.remove(tag);
    });
  }

  void _addProductSize() {
    String size = _productSizeController.text.trim();
    if (size.isNotEmpty) {
      setState(() {
        productSize.add(size);
      });
      _productSizeController.clear();
    }
  }
  void _removeProductSize(String size) {
    setState(() {
      productSize.remove(size);
    });
  }


  void _addProductColor() {
    String color = _productColorController.text.trim();
    if (color.isNotEmpty) {
      setState(() {
        productColor.add(color);
      });
      _productColorController.clear();
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
      String singleImageBase = 'data:image/png;base64,' + base64Encode(singleImageBytes);
      singleImageBase64=singleImageBase;
      print(singleImageBase64);

    }
  }

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
    sellingprice=int.tryParse(_sellingPriceController.text);
    print(sellingprice.runtimeType);
    discountprice=int.tryParse(_discountPriceController.text);
    print(discountprice.runtimeType);



    brandString=selectedbrandId.toString();
    categoryIdString=selectedCategoryId.toString();
    SubCategoryString=selectedSubcategoryId.toString();

    print(productTags.join(','));
    print(productTags.join(',').runtimeType);
    print(hotDealsStatus.toString());
    print(hotDealsStatus.toString().runtimeType);



    if (_formKey.currentState != null && _formKey.currentState!.validate()) {

      try {
        print("data");
        setState(() {
          _isLoading = true;
          _errorMessage = '';
        });
        Options options = Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            // 'Content-Type': 'application/json',
          },
        );
        // FormData formData = FormData();
        // if (_singleImage != null) {
        //   // Convert single image file to Base64
        //   List<int> singleImageBytes = await _singleImage!.readAsBytes();
        //   String singleImageBase64 = 'data:image/png;base64,' + base64Encode(singleImageBytes);
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
        //
        //
        // }
        //
        //
        //
        // // Add the multi images to the FormData
        //
        //
        //
        //
        // print('data2');
        //
        // formData.fields.addAll(
        //     [
        //       MapEntry('product_name' , _productNameController.text),
        //       MapEntry('product_code',_productCodeController.text),
        //       MapEntry('product_tags[]', productTags.join(',')),
        //       MapEntry('product_size[]', productSize.join(',')),
        //       MapEntry('product_color[]', productColor.join(',')),
        //       MapEntry('selling_price',_sellingPriceController.text ),
        //       MapEntry('discount_price', _discountPriceController.text),
        //       MapEntry( 'short_descp', _shortDescpController.text),
        //       MapEntry('long_descp', _longDescpController.text),
        //
        //
        //       MapEntry('status', status.toString()),
        //       MapEntry('brand_id',brandString),
        //       MapEntry( 'category_id',categoryIdString),
        //       MapEntry( 'subcategory_id',SubCategoryString),
        //       MapEntry('vendor_id', widget.vendor_id.toString()),
        //
        //     ]
        // );
        // Make the POST request to the API
        Response response = await Dio().put(
          // 'https://ziizii.mickhae.com/api/vendor/product',
          'https://ziizii.mickhae.com/api/vendor/product/${widget.id}',
          // data: formData,
          data: {
            'product_name': _productNameController.text,
            'product_code': _productCodeController.text,
            'product_tags': productTags,
            'product_size':productSize,
            'product_color': productColor,
            'selling_price': sellingprice,
            'discount_price':discountprice,
            'short_descp': _shortDescpController.text,
            'long_descp': _longDescpController.text,
            'hot_deals': hotDealsStatus.toString(),
            'featured': featuredStatus.toString(),
            'special_offer': specialofferStatus.toString(),
            'special_deals':specialDealsStatus.toString(),
            'product_qty': _productQtyController.text,
            'status': status.toString(),
            'brand_id': brandString,
            'category_id': categoryIdString,
            'subcategory_id': SubCategoryString,
            'vendor_id': widget.vendor_id.toString(),
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
          Navigator.pop(context);

          // Handle the success scenario here
        } else {
          // Handle the failure scenario here
          setState(() {
            _errorMessage = 'Failed to send data to the API';
            print(_errorMessage);
          });
        }
      } catch (error) {
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

  Widget buildImageWidget() {
    if (_multiImages.isNotEmpty) {
      return Container(
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
      );
    }
    else if (widget.multiimageList != null ) {
      return Container(
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.multiimageList!.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Image.network(
                    widget.multiimageList![index].toString(),
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
                              widget.multiimageList!.removeAt(index);
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
      );
    }
    else {
      return Text('No images selected');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Category'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 32),

                //For Product Name
                TextFormField(
                  controller: _productNameController,
                  decoration: InputDecoration(labelText: 'Productname',labelStyle:TextStyle(fontSize: 17,color:Colors.black),enabledBorder : OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3, //<-- SEE HERE
                        color: Colors.blue,
                      ),
                      borderRadius: BorderRadius.circular(12.0)
                  ),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 3, //<-- SEE HERE
                          color: Colors.red,
                        ),
                        borderRadius: BorderRadius.circular(12.0)
                    ),

                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Proudct Name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 32),

                // For Product Tags
                TextField(
                  controller: _productTagsController,
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
                      height:40,

                      decoration: BoxDecoration(
                        color: Colors.blue,

                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              tag!,
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
                  controller: _productSizeController,
                  onSubmitted: (_) => _addProductTag(),
                  decoration: InputDecoration(
                    labelText: 'Product Size',
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
                  children: productSize.map((tag) {
                    return Container(
                      height:40,

                      decoration: BoxDecoration(
                        color: Colors.blue,

                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              tag!,
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



                // For Product Color
                TextField(
                  controller: _productColorController,
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
                      height:40,

                      decoration: BoxDecoration(
                        color: Colors.blue,

                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              tag!,
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



                // For Product Code
                TextFormField(
                  controller: _productCodeController,
                  decoration: InputDecoration(labelText: 'ProductCode',labelStyle:TextStyle(fontSize: 17,color:Colors.black),enabledBorder : OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3, //<-- SEE HERE
                        color: Colors.blue,
                      ),
                      borderRadius: BorderRadius.circular(12.0)
                  ),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 3, //<-- SEE HERE
                          color: Colors.red,
                        ),
                        borderRadius: BorderRadius.circular(12.0)
                    ),

                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Product Slugs';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 32),

                //For Product Qty
                // TextFormField(
                //   controller: _productQtyController,
                //   decoration: InputDecoration(labelText: 'ProductQty',labelStyle:TextStyle(fontSize: 17,color:Colors.black),enabledBorder : OutlineInputBorder(
                //       borderSide: BorderSide(
                //         width: 3, //<-- SEE HERE
                //         color: Colors.blue,
                //       ),
                //       borderRadius: BorderRadius.circular(12.0)
                //   ),
                //     errorBorder: OutlineInputBorder(
                //         borderSide: BorderSide(
                //           width: 3, //<-- SEE HERE
                //           color: Colors.red,
                //         ),
                //         borderRadius: BorderRadius.circular(12.0)
                //     ),
                //
                //   ),
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter Product Slugs';
                //     }
                //     return null;
                //   },
                // ),
                // SizedBox(height: 32),

                //For Product Size




                //For Product Selling Price
                TextFormField(
                  controller: _sellingPriceController,
                  decoration: InputDecoration(labelText: 'ProductSellingPrice',labelStyle:TextStyle(fontSize: 17,color:Colors.black),enabledBorder : OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3, //<-- SEE HERE
                        color: Colors.blue,
                      ),
                      borderRadius: BorderRadius.circular(12.0)
                  ),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 3, //<-- SEE HERE
                          color: Colors.red,
                        ),
                        borderRadius: BorderRadius.circular(12.0)
                    ),

                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Product selling price';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 32),

                //For Product Discuount Price
                TextFormField(
                  controller:_discountPriceController,
                  decoration: InputDecoration(labelText: 'Product Discount Price',labelStyle:TextStyle(fontSize: 17,color:Colors.black),enabledBorder : OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3, //<-- SEE HERE
                        color: Colors.blue,
                      ),
                      borderRadius: BorderRadius.circular(12.0)
                  ),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 3, //<-- SEE HERE
                          color: Colors.red,
                        ),
                        borderRadius: BorderRadius.circular(12.0)
                    ),

                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Product Discount Price';
                    }
                    else if (double.parse(value) >= double.parse(_sellingPriceController.text)) {
                      return 'Please enter a Product Discount Price less than the Selling Price';
                    }

                    return null;
                  },
                ),
                SizedBox(height: 32),

                // For Short Descritpion
                TextFormField(
                  controller:_shortDescpController,
                  decoration: InputDecoration(labelText: 'Product Short Description',labelStyle:TextStyle(fontSize: 17,color:Colors.black),enabledBorder : OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3, //<-- SEE HERE
                        color: Colors.blue,
                      ),
                      borderRadius: BorderRadius.circular(12.0)
                  ),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 3, //<-- SEE HERE
                          color: Colors.red,
                        ),
                        borderRadius: BorderRadius.circular(12.0)
                    ),

                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Product short descrption';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 32),

               //For Long Description
                TextFormField(
                  controller:_longDescpController,
                  decoration: InputDecoration(labelText: 'Product Long Description',labelStyle:TextStyle(fontSize: 17,color:Colors.black),enabledBorder : OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3, //<-- SEE HERE
                        color: Colors.blue,
                      ),
                      borderRadius: BorderRadius.circular(12.0)
                  ),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 3, //<-- SEE HERE
                          color: Colors.red,
                        ),
                        borderRadius: BorderRadius.circular(12.0)
                    ),

                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Product Long Description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 32),







             // For Single image
                ElevatedButton(
                  onPressed: _getSingleImage,
                  child: Text('Choose Product Single Image'),
                ),
                if (_singleImage != null)
                  Image.file(
                    _singleImage!,
                    height: 200,
                  )
                else if (widget.product_thambial != null)
                  Image.network(
                    widget.product_thambial.toString(),
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),


                SizedBox(height:20),

                // for multiimages
                ElevatedButton(
                  onPressed: _getMultiImages,
                  child: Text('Choose Product Multi Images'),
                ),
                SizedBox(height: 16.0),
                buildImageWidget(),






                SizedBox(height: 20),
                // For Category
                Text("Category Name :",style: TextStyle(fontSize: 20),),
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

                //For SubCategory
                Text("Sub Category Name:",style: TextStyle(fontSize: 20),),
                FutureBuilder<SubCategoryApiResponse>(
                  future: _subcategory.getData(),
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
                            items: apiResponse.data.map((subcategory) {
                              return DropdownMenuItem<int>(
                                child: Text(subcategory.subcategory_name.toString()),
                                value: subcategory.id,
                              );
                            }).toList(),
                            onChanged: (int? selectedId) {
                              setState(() {
                                selectedSubcategoryId= selectedId;
                                print(selectedId);

                              });
                            },
                            value: selectedSubcategoryId,
                            hint:Text(widget.subcategoryname),
                          ),
                          selectedSubcategoryId != null
                              ? Text('Selected Subcategory: ${apiResponse.data.firstWhere((category) => category.id == selectedSubcategoryId).subcategory_name}')
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

                //For Brand
                Text("Brand Name:",style: TextStyle(fontSize: 20),),
                FutureBuilder<BrandApiResponse>(
                  future: _brand.getData(),
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
                            items: apiResponse.data.map((brand) {
                              return DropdownMenuItem<int>(
                                child: Text(brand.brand_name.toString()),
                                value: brand.id,
                              );
                            }).toList(),
                            onChanged: (int? selectedId) {
                              setState(() {
                                selectedbrandId= selectedId;
                                print(selectedId);

                              });
                            },
                            value: selectedbrandId,
                            hint:Text(widget.brandname ?? 'Select Brand'),
                          ),
                          selectedbrandId != null
                              ? Text('Selected Brand: ${apiResponse.data.firstWhere((brand) => brand.id == selectedbrandId).brand_name}')
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

                // For Status
                Text("Choose Product Status :",style: TextStyle(fontSize: 16,color:Colors.black),),
                DropdownButton<String>(
                  isExpanded:true,
                  hint: widget.status == 1 ? Text('Active') : Text('Inactive') ,
                  value:statusValue ,
                  onChanged: (String? newValue) {
                    setState(() {
                      statusValue = newValue!;
                      status = (newValue == 'Active') ? 1 : 0;
                      print("Your status is $status");
                    });
                  },
                  items: <String>['Active', 'Inactive'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),

                ),
                SizedBox(height: 30.0),

                //For HotDeals
                Text("Choose Product Status Hot Deals :",style: TextStyle(fontSize: 16,color:Colors.black),),
                DropdownButton<String>(
                  isExpanded:true,
                  hint: widget.hot_deals == 1 ? Text('Yes') : Text("No"),
                  value: hotDealsValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      hotDealsValue = newValue!;
                      hotDealsStatus= (newValue == 'Yes') ? 1 : 0;
                      print("Your status is $status");
                    });
                  },
                  items: <String>['Yes','No'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),

                ),
                SizedBox(height: 30.0),

                //For Featured
                Text("Choose Product Status Featured :",style: TextStyle(fontSize: 16,color:Colors.black),),
                DropdownButton<String>(
                  isExpanded:true,
                  hint:widget.featured == 1 ? Text('Yes') : Text("No"),
                  value:featuredValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      featuredValue = newValue!;
                      specialDealsStatus= (newValue == 'Yes') ? 1 : 0;
                      print("Your status is $status");
                    });
                  },
                  items: <String>['Yes', 'No'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),

                ),
                SizedBox(height: 30.0),

                // For Special Offers
                Text("Choose Product Status Special Offers :",style: TextStyle(fontSize: 16,color:Colors.black),),
                DropdownButton<String>(
                  isExpanded:true,
                  hint: widget.special_offer == 1 ? Text('Yes') : Text("No"),
                  value: specialofferValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      specialofferValue = newValue!;
                      specialofferStatus = (newValue == 'Yes') ? 1 : 0;
                      print("Your status is $status");
                    });
                  },
                  items: <String>['Yes', 'No'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),

                ),
                SizedBox(height: 30.0),

                // For Special Deals
                Text("Choose Product Status Special Deals :",style: TextStyle(fontSize: 16,color:Colors.black),),
                DropdownButton<String>(
                  isExpanded:true,
                  hint: widget.special_deals == 1 ? Text('Yes') : Text("No"),
                  value: specialDealsValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      specialDealsValue = newValue!;
                      specialDealsStatus = (newValue == 'Yes') ? 1 : 0;
                      print("Your status is $status");
                    });
                  },
                  items: <String>['Yes', 'No'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),

                ),
                SizedBox(height: 30.0),

                ElevatedButton(
                  onPressed: _isLoading ? null : _submitForm,
                  child: _isLoading ? CircularProgressIndicator() : Text(
                      'Create Product'),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
