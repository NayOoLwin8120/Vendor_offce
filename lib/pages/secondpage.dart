import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vendor/Model/Dashboard%20Page%20Model/dashboard_model.dart';
import 'package:vendor/authentication/controllers/login_controller.dart';
import 'package:vendor/authentication/models/user_detail_model.dart';
import 'package:vendor/authentication/views/forgetpassword.dart';
import 'package:vendor/authentication/views/notifications.dart';
import 'package:vendor/controllers/Dashboard%20Page%20Controller/dashboard_controller.dart';
import 'package:vendor/pages/Brand%20Page/brand.dart';
import 'package:vendor/pages/Brand%20Page/search_brand_page.dart';
import 'package:vendor/pages/Category%20Page/Sub%20Category%20Page/sub_category.dart';
import 'package:vendor/pages/Category%20Page/Sub%20Category%20Page/sub_category_search.dart';
import 'package:vendor/pages/Category%20Page/category.dart';
import 'package:vendor/pages/Category%20Page/category_search_page.dart';
import 'package:vendor/pages/Dashboard%20Page/dashboard.dart';
import 'package:vendor/pages/Dashboard%20Page/searchdashboard.dart';
import 'package:vendor/pages/Product%20Page/product.dart';


import 'package:vendor/authentication/views/userdetail2.dart';
import 'package:vendor/pages/Product%20Page/product_search_page.dart';

// import 'Category Page/category_search.dart';




class Second extends StatefulWidget {


  const Second({Key? key}) : super(key: key);

  @override
  State<Second> createState() => _SecondState();
}


class _SecondState extends State<Second> {
  // late Future<DashboardData> _dashboarddata;
  final ApiController _dash=ApiController();
  // List _dataList =[];
  var _currentIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Dashboard(),
  Category_page(),
  // Category_Search_page(),
    Sub_Category(),
    Product(),
    Brand(),
  ];

  String _title = 'Home';
  final userModel = UserModel();

  void _onItemTapped(int index){
    setState(() {
      _currentIndex=index;
      if (index == 0) {
        _title = 'Home Page';
      } else if (index == 1) {
        _title = ' Category Page';
      }else if(index == 2){
        _title='Sub_Category Page';
      } else if (index == 3) {
        _title = 'Products Page';
      }else{
        _title="Brand Page";
      }
    });
  }
  @override
  void initState() {
    super.initState();
    // _dashboarddata =_dash.getDashboardData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar:
      AppBar(
        title: Center(child: Text(_title)),
        actions:
          <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications_active),
            tooltip: 'Show notifications',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>Notifications(),
                  ),
              );
            },
          ),
          if (_currentIndex == 0)
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: SearchDashboard());
              },
            )
            else if(_currentIndex == 1)
              IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: SearchCategory());
              },
              )
              else if(_currentIndex == 2)
              IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: SubCategorySearch());

              },
              )
              else if(_currentIndex == 3)
              IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
               showSearch(context: context, delegate:ProductSearchPage());
              },
              )
              else if(_currentIndex == 4)
              IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: SearchBrandPage());

              },
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
                final imageBytes = base64Decode(userData['data']['photo']);
                print(imageBytes);
                return ListView(
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
                            // backgroundImage: NetworkImage('https://media.istockphoto.com/vectors/default-image-icon-vector-missing-picture-page-for-website-design-or-vector-id1357365823?b=1&k=20&m=1357365823&s=170667a&w=0&h=y6ufWZhEt3vYWetga7F33Unbfta2oQXCZLUsEa67ydM='),
                            backgroundImage:
                                 (userData['data']['photo'] != null)
                                ? NetworkImage(
                              userData['data']['photo'].toString(),
                            )
                                : NetworkImage('https://media.istockphoto.com/vectors/default-image-icon-vector-missing-picture-page-for-website-design-or-vector-id1357365823?b=1&k=20&m=1357365823&s=170667a&w=0&h=y6ufWZhEt3vYWetga7F33Unbfta2oQXCZLUsEa67ydM='),

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
                          leading: const Icon(Icons.password),
                          title:Text('Forgot Password'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(


                                builder:(context)=>ForgetPassword(id:userData['data']['id']),
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
      // body: _widgetOptions.elementAt(_currentIndex),
      body:SafeArea(child: _widgetOptions[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor:Colors.blue,
            icon: Icon(Icons.home),
            label: 'Home Page',
          ),
          BottomNavigationBarItem(
            backgroundColor:Colors.blue,
            icon: Icon(Icons.category_outlined),
            label: 'Category Page',
          ),
          BottomNavigationBarItem(
            backgroundColor:Colors.blue,
            icon: Icon(Icons.business_sharp),
            label: 'Sub_Category Page',
          ),
          BottomNavigationBarItem(
            backgroundColor:Colors.blue,
            icon: ImageIcon(AssetImage("assets/images/new-product.png"),color: Colors.red,
              size:50,),
            label: 'Products  Page',
          ),
          BottomNavigationBarItem(
            backgroundColor:Colors.blue,
            icon: Icon(Icons.shopping_bag),
            label: 'Brands Page',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
