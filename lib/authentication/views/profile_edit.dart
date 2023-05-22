import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vendor/authentication/controllers/profile_update_controller.dart';
import 'package:vendor/custom_config/util/custom_image_convetor.dart';

class ProfileEditPage extends StatefulWidget {
  final Map<String, dynamic> userData;
  const ProfileEditPage({Key? key,required this.userData}) : super(key: key);

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {



  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _shortinfoController = TextEditingController();
  TextEditingController _vedorjoinController = TextEditingController();
  bool _isImageSelected=false;
  File? image;
  File? imagelocal;
   String? imageapi;
  File? _imagefile;
  File? _singleImage;
  final ProfileController _controller = ProfileController();
  final picker = ImagePicker();
  String singleImageBase64='';
  // Future<void> _pickGalleryImage() async {
  //   try{
  //     final pickedimage= await ImagePicker().pickImage(source: ImageSource.gallery);
  //     if (pickedimage == null) return;
  //     // print(pickedimage.path);
  //     File imagefile=File(pickedimage.path);
  //     // print(imageFile);
  //     Uint8List imagebytes = await imagefile.readAsBytes();
  //     String base64string = base64.encode(imagebytes);
  //
  //     Uint8List decodedbytes = base64.decode(base64string);
  //     print(decodedbytes);
  //     final imageTemporay=File(pickedimage.path );
  //
  //
  //     final imagePermant=await _saveImage(pickedimage.path);
  //     // final readbytes = await (imagePermant ?? imageTemporay).readAsBytes();
  //     final readbytes= await imageTemporay.readAsBytes();
  //     final base64image=await unit8ToBase64(readbytes as Uint8List, "image/jpeg");
  //
  //     setState(() {
  //       _imagefile=File(pickedimage.path);
  //
  //       imageapi=base64image;
  //       this.imagelocal=imageTemporay;
  //       // this.imagelocal=imagePermant;
  //     });
  //   }on PlatformException catch (e){
  //     print("Failed to picked image: $e");
  //   }
  //
  // }

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
      String singleImageBase = 'data:image/png;base64' + base64Encode(singleImageBytes);
      singleImageBase64=singleImageBase;
      print(singleImageBase64);

    }
  }
  // Future<File?> _saveImage(String imagepath) async {
  //   if (image != null) {
  //     final directory = await getApplicationDocumentsDirectory() ;
  //
  //     final fileName = DateTime.now().toIso8601String();
  //     final filepath = File('${directory.path}/$fileName.png');
  //
  //     await filepath.writeAsBytes(await image!.readAsBytes());
  //     // print('${directory.path}/$fileName.png');
  //     return File(imagepath).copy('${directory.path}/$fileName.png');
  //   }
  //   return null;
  // }
  Future<void> _pickCameraImage() async {
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemporay=File(image.path );
      setState(() {
        this.image=imageTemporay;
      });
    }on PlatformException catch (e){
      print("Failed to picked image: $e");
    }

    // setState(() {
    //   _image = File(pickedFile.path);
    // });

  }
  Future<void> _selectImage() async {
    final pickedFile = await showDialog<File>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose an option'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: const Text('Gallery'),
                  onTap: () async {
                    _getSingleImage();

                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  child: const Text('Camera'),
                  onTap: () async {
                    _pickCameraImage();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );


  }
  void _onUpdateDataPressed(BuildContext context) {
    if (_formKey.currentState?.validate() == true) {

      final name = _nameController.text.trim();
      final username = _usernameController.text.trim();
      final phonenumber = _phoneController.text.trim();
      final email = _emailController.text.trim();
      print(email);
      final shortinfo=_shortinfoController.text.trim();
      final address=_addressController.text.trim();
      final vendor_join=_vedorjoinController.text.trim();
      // final image=_imagefile;
      final image=imageapi;
      _controller
          .authenticate(
          context,
          name,
          username,
          email,
          phonenumber,
          address,
          shortinfo,
          vendor_join,
         singleImageBase64)
          .then((value) {});
      // _controller.authenticate(context,name,username,email,phonenumber,address,shortinfo,vendor_join,image as File)
      //     .then((value) {
      //
      // });
    }
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.userData['data']['name'] ?? '';
    _usernameController.text = widget.userData['data']['username'] ?? '';
    _emailController.text = widget.userData['data']['email'] ?? '';
    _phoneController.text = widget.userData['data']['phone'] ?? '';
    _addressController.text = widget.userData['data']['address'] ?? '';
    _shortinfoController.text = widget.userData['data']['vendor_short_info'] ?? '';
    _vedorjoinController.text = widget.userData['data']['vendor_join'] ?? '';
  }
  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _shortinfoController.dispose();
    _vedorjoinController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Edit Profile'),
    ),
    body: Form(
    key: _formKey,
    child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      const SizedBox(height: 20),
      Center(
      child: GestureDetector(
      onTap: () {
             _selectImage();
        },
      child: CircleAvatar(
      radius: 50,
      // backgroundImage:
      // imagelocal!=null ? Image.file(imagelocal!,width:160,height:160,fit:BoxFit.cover).image :
      // NetworkImage('${widget.userData['data']['photo']}') as ImageProvider<Object> ,
        backgroundImage: _isImageSelected

            ? FileImage(File(_imagefile!.path))
            : NetworkImage('${widget.userData['data']['photo']}') as ImageProvider<Object>,
      child: Icon(
      Icons.camera_alt,
      size: 30,
      color: Colors.white.withOpacity(0.7),
      ),
      ),
      ),
      ),
      const SizedBox(height: 30),
      Text(
      'Name',
      style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).primaryColor,
      ),
      ),
      const SizedBox(height: 10),
      TextFormField(
      controller: _nameController,
      decoration: InputDecoration(
      hintText: 'Enter your name',
      border: OutlineInputBorder(),
      ),

      validator: (value) {
      if (value!.isEmpty) {
      return 'Please enter your name';
      }
      return null;
      },
      ),
      const SizedBox(height: 20),
        Text(
          'UserName',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _usernameController,
          decoration: InputDecoration(
            hintText: 'Enter your username',
            border: OutlineInputBorder(),
          ),

          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your username';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
      Text(
      'Email',
      style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).primaryColor,
      ),
      ),
      const SizedBox(height: 10),
      TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
      hintText: 'Enter your email',
      border: OutlineInputBorder(),
      ),
      validator: (value) {
      if (value!.isEmpty) {
      return 'Please enter your email';
      } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return 'Please enter a valid email';
      }
      return null;
      },
      ),
      const SizedBox(height: 20),
      Text(
      'Phone Number',
      style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).primaryColor,
      ),
      ),
      const SizedBox(height: 10),
      TextFormField(
      controller: _phoneController,
      decoration: InputDecoration(
      hintText: 'Enter your phone number',
      border: OutlineInputBorder(),
      ),
      validator: (value) {
      if (value!.isEmpty) {
      return 'Please enter your phone number';
      }
      return null;
      },
      ),
        SizedBox(height: 30,),
        Text(
          'Short_info',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),

        const SizedBox(height: 10),
        TextFormField(
          controller: _shortinfoController,
          decoration: InputDecoration(
            hintText: 'Enter your Short Description',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter Short  Description';
            }
            return null;
          },
        ),

        SizedBox(height: 30,),
        Text(
          'Vendor_join',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),

        const SizedBox(height: 10),
        TextFormField(
          controller: _vedorjoinController,
          decoration: InputDecoration(
            hintText: 'Vendor_join',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter Short  Description';
            }
            return null;
          },
        ),
        SizedBox(height: 30,),
        Text(
          'Address',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),

        const SizedBox(height: 10),
        TextFormField(
          controller: _addressController,
          decoration: InputDecoration(
            hintText: 'Enter your address',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your address';
            }
            return null;
          },
        ),
      const SizedBox(height: 30),
      Center(
      child: ElevatedButton(
      onPressed: () {
        setState(() {
          print("Hello");
        });

      if (_formKey.currentState!.validate()) {
        _onUpdateDataPressed(context);
      }
      },
      child: const Text('Save Changes'),
      ),
      ),

        ],
      ),
    ),
    ),
    ),
    );
  }


}