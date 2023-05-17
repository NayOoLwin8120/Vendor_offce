import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vendor/Model/Dashboard%20Page%20Model/dashboard_model.dart';
import 'package:vendor/authentication/controllers/login_controller.dart';
import 'package:vendor/authentication/models/user_detail_model.dart';
import 'package:vendor/authentication/views/notifications.dart';
import 'package:vendor/controllers/Dashboard%20Page%20Controller/dashboard_controller.dart';
import 'package:vendor/pages/Brand%20Page/brand.dart';
import 'package:vendor/pages/Category%20Page/Sub%20Category%20Page/sub_category.dart';
import 'package:vendor/pages/Category%20Page/category.dart';
import 'package:vendor/pages/Dashboard%20Page/dashboard.dart';
import 'package:vendor/pages/Product%20Page/product.dart';
import 'package:vendor/authentication/views/userdetail2.dart';

class SecondPg extends StatefulWidget {
  const SecondPg({Key? key}) : super(key: key);

  @override
  State<SecondPg> createState() => _SecondPgState();
}

class _SecondPgState extends State<SecondPg> {
  final ApiController _dash = ApiController();
  final ScrollController _scrollController = ScrollController();
  var _currentIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Dashboard(),
    Category_page(),
    Sub_Category(),
    Product(),
    Brand(),
  ];

  String _title = 'Home';
  final userModel = UserModel();

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (index == 0) {
        _title = 'Home Page';
      } else if (index == 1) {
        _title = ' Category Page';
      } else if (index == 2) {
        _title = 'Sub_Category Page';
      } else if (index == 3) {
        _title = 'Products Page';
      } else {
        _title = "Brand Page";
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(_title),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.notifications_active),
                tooltip: 'Show notifications',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Notifications(),
                    ),
                  );
                },
              ),
            ],
            floating: true,
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate(_widgetOptions),
          ),

        ],
      ),
      drawer: Drawer(
        child: FutureBuilder<Map<String, dynamic>?>(
          future: userModel.getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Lottie.network('https://assets2.lottiefiles.com/packages/lf20_poqmycwy.json',width: 50,height: 50);
            } else if (snapshot.connectionState == ConnectionState.done) {
              final userData = snapshot.data!;
              //fix this error for image
              if(userData == null && userData['photo'] == null){
                final imageBytes = base64Decode(userData['data']['photo']);                return ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    UserAccountsDrawerHeader(
                      decoration: const BoxDecoration(
                        color: Color(0xff764abc),
                      ),
                      accountName: Text(
                        "Pinkesh Darji",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      accountEmail: Text(
                        "pinkesh.earth@gmail.com",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      currentAccountPicture: CircleAvatar(
                        backgroundImage: MemoryImage(imageBytes),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.home),
                      title: const Text('Page 1'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.train),
                      title: const Text('Page 2'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              }
              else{
                return Container(
                  padding: EdgeInsets.zero,
                  child:Column(
                    children:
                    [
                      UserAccountsDrawerHeader(
                        decoration: const BoxDecoration(
                          color: Color(0xff764abc),
                        ),
                        accountName: Text(
                          userData['data']['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        accountEmail: Text(
                          userData['data']['email'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        currentAccountPicture: CircleAvatar(
                          backgroundImage: NetworkImage('https://media.istockphoto.com/vectors/default-image-icon-vector-missing-picture-page-for-website-design-or-vector-id1357365823?b=1&k=20&m=1357365823&s=170667a&w=0&h=y6ufWZhEt3vYWetga7F33Unbfta2oQXCZLUsEa67ydM='),

                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.home),
                        title:Text('Details'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(

                              builder: (context) {
                                return FutureBuilder<Map<String, dynamic>?>(
                                  future:userModel.getUserData() ,
                                  builder: (context,  snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return Lottie.network("https://assets6.lottiefiles.com/private_files/lf30_jo7huq2d.json");
                                    }
                                    else if (snapshot.connectionState == ConnectionState.done) {
                                      final userData = snapshot.data!;
                                      return UserDetailScreen(userData: userData) ;
                                      // return Userdetail() ;
                                    }
                                    else if (snapshot.hasError){
                                      return Lottie.network('https://assets9.lottiefiles.com/packages/lf20_0hj4Khn1at.json');
                                    } else{
                                      return Text("No found");
                                    }
                                  },
                                );
                              },
                              // builder:(context)=>UserDetailScreen(),
                            ),
                          );
                        },
                      ),

                      ListTile(
                        leading: const Icon(Icons.logout),
                        title: const Text('Logout'),
                        onTap: () {
                          LoginController().logout(context);
                        },
                      ),
                    ],

                  ),

                );
              }

            } else if (snapshot.hasError) {
              return const Text('Error connecting to API');
            } else {
              return const Text("No image Found");
            }
          },
        ),
      ),
      bottomNavigationBar: AnimatedBuilder(
        animation: _scrollController,
        builder: (context, child) {
          bool show = _scrollController.offset > MediaQuery.of(context).padding.top;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: show ? kBottomNavigationBarHeight : 0,
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: _onItemTapped,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Category'),
                BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Sub-Category'),
                BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Products'),
                BottomNavigationBarItem(icon: Icon(Icons.branding_watermark), label: 'Brand'),
              ],
            ),
          );
        },
      ),
    );
  }


}


