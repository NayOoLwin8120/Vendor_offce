import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vendor/authentication/controllers/login_controller.dart';
import 'package:vendor/authentication/views/profile_edit.dart';

class UserDetailScreen extends StatefulWidget {
  final Map<String, dynamic> userData;
  const UserDetailScreen({Key? key,required this.userData}) : super(key: key);

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

 class _UserDetailScreenState extends State<UserDetailScreen> {
     late String imageUrl=widget.userData['data']['photo'];

    ImageProvider<Object>? imageProvider;

  @override
  void initState() {
    super.initState();
    imageUrl = widget.userData['data']['photo'];
    _loadImage();

    // print(imageUrl);
  }

   Future<void> _loadImage() async {
     var imageBytes = base64Decode(imageUrl);
     String fileName = 'image.jpg';
     File file = await File(fileName).writeAsBytes(imageBytes);
     setState(() {
       imageProvider = FileImage(file);
     });
   }



   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),

        actions: [
          TextButton(
            child:Text("Logout",style:TextStyle(color:Colors.white) ),
            onPressed: () {
              // LoginController().logout(context);
              LoginController().logout(context);
            },
          ),
          IconButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileEditPage(userData: widget.userData)));
          }, icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Center(
              child: CircleAvatar(
                radius: 50,
                // backgroundImage: NetworkImage(
                //   'https://i.pravatar.cc/150?img=1',
                // ),

                // backgroundImage: NetworkImage('https://media.istockphoto.com/vectors/default-image-icon-vector-missing-picture-page-for-website-design-or-vector-id1357365823?b=1&k=20&m=1357365823&s=170667a&w=0&h=y6ufWZhEt3vYWetga7F33Unbfta2oQXCZLUsEa67ydM='),
                backgroundImage: widget.userData['data']['photo'] != null ? NetworkImage(widget.userData['data']['photo']): NetworkImage('https://media.istockphoto.com/vectors/default-image-icon-vector-missing-picture-page-for-website-design-or-vector-id1357365823?b=1&k=20&m=1357365823&s=170667a&w=0&h=y6ufWZhEt3vYWetga7F33Unbfta2oQXCZLUsEa67ydM='),
              ),
            ),
            const SizedBox(height: 20),
             Text(
              '${widget.userData['data']['name']}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            //username
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width:double.infinity,
                height:50,
                decoration: BoxDecoration(
                  color:Colors.blue,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'User_name  :',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                     Text(
                      '${widget.userData['data']['username']}',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            //email
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width:double.infinity,
                height:50,
                decoration: BoxDecoration(
                  color:Colors.blue,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Email  :',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                     Text(
                      '${widget.userData['data']['email']}',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            //phone
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width:double.infinity,
                height:50,
                decoration: BoxDecoration(
                  color:Colors.blue,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Phone_number  :',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                     Text(
                      '${widget.userData['data']['phone']}',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            //address
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width:double.infinity,
                height:50,
                decoration: BoxDecoration(
                  color:Colors.blue,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Address  :',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '${widget.userData['data']['address']}',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            //vendor_join
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width:double.infinity,
                height:50,
                decoration: BoxDecoration(
                  color:Colors.blue,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Vendor join :',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '${widget.userData['data']['vendor_join']}',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),

            //role active
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width:double.infinity,
                height:50,
                decoration: BoxDecoration(
                  color:Colors.blue,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Status :',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                     Text(
                      '${widget.userData['data']['status']}',
                      // '${DateFormat.yMMMEd().format(widget.userData['data']['created_at'])}',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            //expire at
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width:double.infinity,
                height:50,
                decoration: BoxDecoration(
                  color:Colors.blue,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Expired_at  :',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                     Text(
                      '${widget.userData['data']['token_expired_at']}',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            //create at
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width:double.infinity,
                height:50,
                decoration: BoxDecoration(
                  color:Colors.blue,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Wrap(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Create_at :',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    Text(


                      '${widget.userData['data']['created_at']}',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
