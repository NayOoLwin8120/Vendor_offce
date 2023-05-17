import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerPage extends StatefulWidget {
  @override
  _ImagePickerPageState createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  List<File> _multiImages = [];
  File? _singleImage;

  final picker = ImagePicker();

  Future<void> _getSingleImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _singleImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _getMultiImages() async {
    final pickedFiles = await ImagePicker().pickMultiImage();

    if (pickedFiles != null) {
      setState(() {
        _multiImages =
            pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
      });
    }
  }

  Future<void> _uploadData() async {
    try {
      // Create Dio instance
      final dio = Dio();

      // Add single image (if selected) to FormData
      final formData = FormData();
      if (_singleImage != null) {
        print(_singleImage);
        final bytes = await _singleImage!.readAsBytes();
        final base64Image = base64Encode(bytes);
        formData.fields.add(MapEntry('singleImage', await base64Image));
        print(base64Image);
      }

      // Add multi images (if selected) to FormData
      if (_multiImages.isNotEmpty) {
        for (int i = 0; i < _multiImages.length; i++) {
          final bytes = await _multiImages[i].readAsBytes();
          final base64Image = base64Encode(bytes);
          formData.fields.add(
              MapEntry('multiImages[$i]', base64Image));
        }
      }

      // Add other form fields to FormData
      formData.fields.add(MapEntry('field1', 'Value1'));
      formData.fields.add(MapEntry('field2', 'Value2'));

      // Send data to API endpoint
      final response = await dio.post(
          'https://example.com/api/upload', data: formData);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data uploaded successfully'),
        ),
      );
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error uploading data'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Demo'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Single Image Picker
            ElevatedButton(
              onPressed: _getSingleImage,
              child: Text('Pick Single Image'),
            ),
            if (_singleImage != null)
              Image.file(
                _singleImage!,
                height: 200,
              ),
            SizedBox(height: 16),

            // Multi Image Picker
            ElevatedButton(
              onPressed: _getMultiImages,
              child: Text('Pick Multiple Images'),
            ),
            SizedBox(height:30),
            if (_multiImages.isNotEmpty)
              Container(

               height:200,
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
                            top:-15,
                            right: -15,
                            child: Container(

                              width: 40,
                              height:40,
                              decoration:BoxDecoration(
                                color:Colors.white,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                child: IconButton(
                                  icon: Icon(Icons.close_sharp,color: Colors.black,size: 25,),
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
            SizedBox(height: 16),

            // Upload Button
            ElevatedButton(
              onPressed: _uploadData,
              child: Text('Upload Data'),
            ),
          ],
        ),
      ),
    );
  }
}
