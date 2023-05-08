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
import 'package:vendor/pages/Category%20Page/category.dart';
import 'package:vendor/pages/Dashboard%20Page/dashboard.dart';
import 'package:vendor/pages/Product%20Page/product.dart';


import 'package:vendor/authentication/views/userdetail2.dart';




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
      } else if (index == 2) {
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
      appBar: AppBar(
        title: Center(child: Text(_title)),
        actions: <Widget>[
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
          // TextButton(
          //   child:Text("Logout",style:TextStyle(color:Colors.white) ,),
          //
          //   onPressed: () {
          //     LoginController().logout(context);
          //   },
          // ),


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
      // body: _widgetOptions.elementAt(_currentIndex),
      body:_widgetOptions[_currentIndex],
     // body: SafeArea(
     //    child: Scrollbar(
     //      child: SingleChildScrollView(
     //        scrollDirection: Axis.vertical,
     //        child: Column(
     //          children: [
     //            FutureBuilder<ApiResponse>(
     //              future:_dash.getData(),
     //              builder: (context, snapshot) {
     //                if (snapshot.hasData) {
     //
     //                  if (snapshot.connectionState == ConnectionState.waiting) {
     //                    return Center(child: Column(
     //                      mainAxisAlignment:MainAxisAlignment.center,
     //                      children: [
     //                        Center(child: Text("Data are Loading")),
     //                        Center(child: CircularProgressIndicator()),
     //                      ],
     //                    ));
     //                  }
     //                  if (snapshot.hasError) {
     //                    return Center(child: Text('Error fetching data'));
     //                  }
     //                  final apiResponse = snapshot.data!;
     //
     //                  return SingleChildScrollView(
     //                    scrollDirection: Axis.vertical,
     //                    child: Column(
     //                      children: [
     //                        SizedBox(height:20),
     //                        Container(child: Row(
     //                          mainAxisAlignment: MainAxisAlignment.center,
     //                          children: [
     //                            Text("Your Vendor Account is ",style: TextStyle(fontSize: 18),),
     //                            Text("Active ",style: TextStyle(fontSize: 20,color: Colors.green),),
     //                          ],
     //                        )),
     //                        SizedBox(height:20),
     //                        Text("${apiResponse.message}"),
     //                        SizedBox(height:20),
     //                        Container(
     //                          child: Row(
     //                            children: [
     //                              Card(
     //                                color:Colors.deepOrangeAccent,
     //                                elevation: 1,
     //                                shape: RoundedRectangleBorder(
     //                                  side: BorderSide(
     //                                    color: Theme.of(context).colorScheme.outline,
     //                                  ),
     //                                  borderRadius: const BorderRadius.all(Radius.circular(12)),
     //                                ),
     //                                child: Container(
     //                                  width: 120,
     //                                  height:100,
     //                                  child: Column(
     //                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
     //                                    crossAxisAlignment: CrossAxisAlignment.center,
     //                                    children: [
     //                                      Container(
     //                                        child: Row(
     //                                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
     //                                          children: [
     //                                            Container(
     //
     //                                              child:
     //                                              Row(
     //                                                children: [
     //                                                  Icon(Icons.monetization_on,size: 18,),
     //                                                  Text("${apiResponse.monthly_Sale.toString()}",style: TextStyle(fontSize: 18),),
     //                                                  Text("USD",style: TextStyle(fontSize: 18),),
     //                                                ],
     //                                              ),
     //                                            ),
     //                                            Icon(Icons.shopping_cart_rounded,size: 18,),
     //                                          ],
     //                                        ),
     //                                      ),
     //                                      Container(
     //                                        width:100,
     //                                        height:3,
     //                                        color: Colors.black,
     //                                      ),
     //                                      Text("Monthly Sale",style: TextStyle(fontSize: 20),)
     //
     //                                    ],
     //                                  ),
     //                                ),
     //                                ),
     //                              Card(
     //                                color:Colors.deepOrangeAccent,
     //                                elevation: 1,
     //                                shape: RoundedRectangleBorder(
     //                                  side: BorderSide(
     //                                    color: Theme.of(context).colorScheme.outline,
     //                                  ),
     //                                  borderRadius: const BorderRadius.all(Radius.circular(12)),
     //                                ),
     //                                child: Container(
     //                                  width: 120,
     //                                  height:100,
     //                                  child: Column(
     //                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
     //                                    crossAxisAlignment: CrossAxisAlignment.center,
     //                                    children: [
     //                                      Container(
     //                                        child: Row(
     //                                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
     //                                          children: [
     //                                            Container(
     //
     //                                              child:
     //                                              Row(
     //                                                children: [
     //                                                  Icon(Icons.monetization_on,size: 18,),
     //                                                  Text("${apiResponse.monthly_Sale.toString()}",style: TextStyle(fontSize: 18),),
     //                                                  Text("USD",style: TextStyle(fontSize: 18),),
     //                                                ],
     //                                              ),
     //                                            ),
     //                                            Icon(Icons.shopping_cart_rounded,size: 18,),
     //                                          ],
     //                                        ),
     //                                      ),
     //                                      Container(
     //                                        width:100,
     //                                        height:3,
     //                                        color: Colors.black,
     //                                      ),
     //                                      Text("Monthly Sale",style: TextStyle(fontSize: 20),)
     //
     //                                    ],
     //                                  ),
     //                                ),
     //                              ),
     //                              Card(
     //                                color:Colors.deepOrangeAccent,
     //                                elevation: 1,
     //                                shape: RoundedRectangleBorder(
     //                                  side: BorderSide(
     //                                    color: Theme.of(context).colorScheme.outline,
     //                                  ),
     //                                  borderRadius: const BorderRadius.all(Radius.circular(12)),
     //                                ),
     //                                child: Container(
     //                                  width: 120,
     //                                  height:100,
     //                                  child: Column(
     //                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
     //                                    crossAxisAlignment: CrossAxisAlignment.center,
     //                                    children: [
     //                                      Container(
     //                                        child: Row(
     //                                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
     //                                          children: [
     //                                            Container(
     //
     //                                              child:
     //                                              Row(
     //                                                children: [
     //                                                  Icon(Icons.monetization_on,size: 18,),
     //                                                  Text("${apiResponse.monthly_Sale.toString()}",style: TextStyle(fontSize: 18),),
     //                                                  Text("USD",style: TextStyle(fontSize: 18),),
     //                                                ],
     //                                              ),
     //                                            ),
     //                                            Icon(Icons.shopping_cart_rounded,size: 18,),
     //                                          ],
     //                                        ),
     //                                      ),
     //                                      Container(
     //                                        width:100,
     //                                        height:3,
     //                                        color: Colors.black,
     //                                      ),
     //                                      Text("Monthly Sale",style: TextStyle(fontSize: 20),)
     //
     //                                    ],
     //                                  ),
     //                                ),
     //                              ),
     //                            ],
     //                          ),
     //                        ),
     //
     //                        SizedBox(height:20),
     //                        SingleChildScrollView(
     //                          scrollDirection: Axis.horizontal,
     //                          child: Container(
     //                              child:Row(
     //                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
     //                                children: [
     //                                  Padding(
     //                                    padding: const EdgeInsets.all(1.0),
     //                                    child: Container(
     //                                        width: 120,
     //                                        height:100,
     //                                        color:Colors.green,
     //                                        child:
     //                                        Column(
     //                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
     //                                          crossAxisAlignment: CrossAxisAlignment.center,
     //                                          children: [
     //                                            Container(
     //                                              child: Row(
     //                                                mainAxisAlignment:MainAxisAlignment.spaceBetween,
     //                                                children: [
     //                                                  Container(
     //                                                    child:
     //                                                    Row(
     //                                                      children: [
     //                                                        Icon(Icons.monetization_on,size: 18,),
     //                                                        Text("${apiResponse.monthly_Sale.toString()}",style: TextStyle(fontSize: 18),),
     //                                                        Text("USD",style: TextStyle(fontSize: 18),),
     //                                                      ],
     //                                                    ),
     //                                                  ),
     //                                                  Icon(Icons.shopping_cart_rounded,size: 18,),
     //                                                ],
     //                                              ),
     //                                            ),
     //                                            Container(
     //                                              width:100,
     //                                              height:3,
     //                                              color: Colors.black,
     //                                            ),
     //                                            Text("Monthly Sale",style: TextStyle(fontSize: 20),)
     //
     //                                          ],
     //                                        )
     //                                    ),
     //                                  ),
     //                                  Padding(
     //                                    padding: const EdgeInsets.all(2.0),
     //                                    child: Container(
     //                                        width: 120,
     //                                        height:100,
     //                                        color:Colors.green,
     //                                        child:Column(
     //                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
     //                                          crossAxisAlignment: CrossAxisAlignment.center,
     //                                          children: [
     //                                            Container(
     //                                              child: Row(
     //                                                mainAxisAlignment:MainAxisAlignment.spaceBetween,
     //                                                children: [
     //                                                  Container(
     //
     //                                                    child:
     //                                                    Row(
     //                                                      children: [
     //                                                        Icon(Icons.monetization_on,size: 18,),
     //                                                        Text("${apiResponse.yearly_Sale}",style: TextStyle(fontSize: 18),),
     //                                                        Text("USD",style: TextStyle(fontSize: 18),),
     //                                                      ],
     //                                                    ),
     //                                                  ),
     //                                                  Icon(Icons.shopping_cart_rounded,size: 18,),
     //                                                ],
     //                                              ),
     //                                            ),
     //                                            Container(
     //                                              width:100,
     //                                              height:3,
     //                                              color: Colors.black,
     //                                            ),
     //                                            Text("Yearly Sale",style: TextStyle(fontSize: 20),)
     //
     //                                          ],
     //                                        )
     //                                    ),
     //                                  ),
     //                                  Padding(
     //                                    padding: const EdgeInsets.all(2.0),
     //                                    child: Container(
     //                                        width: 120,
     //                                        height:100,
     //                                        color:Colors.green,
     //                                        child:Column(
     //                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
     //                                          crossAxisAlignment: CrossAxisAlignment.center,
     //                                          children: [
     //                                            Container(
     //                                              child: Row(
     //                                                mainAxisAlignment:MainAxisAlignment.spaceBetween,
     //                                                children: [
     //                                                  Container(
     //                                                    child:
     //                                                    Row(
     //                                                      children: [
     //                                                        Icon(Icons.monetization_on,size: 18,),
     //                                                        Text("${apiResponse.today_Sale}",style: TextStyle(fontSize: 18),),
     //                                                        Text("USD",style: TextStyle(fontSize: 18),),
     //                                                      ],
     //                                                    ),
     //                                                  ),
     //                                                  Icon(Icons.shopping_cart_rounded,size: 18,),
     //                                                ],
     //                                              ),
     //                                            ),
     //                                            Container(
     //                                              width:100,
     //                                              height:3,
     //                                              color: Colors.black,
     //                                            ),
     //                                            Text("Today Sale",style: TextStyle(fontSize: 20),)
     //
     //                                          ],
     //                                        )
     //                                    ),
     //                                  ),
     //
     //                                ],
     //                              )
     //                          ),
     //                        ),
     //                        SizedBox(height:10),
     //                        Container(
     //                            width:double.infinity,
     //                            height:500,
     //                            color:Colors.blue,
     //                            child:Column(
     //                              children: [
     //                                Container(
     //                                  color:Colors.white38,
     //                                  child: Row(
     //                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
     //                                    children: [
     //                                      Text("Order Summary",style: TextStyle(fontSize: 20),),
     //                                      IconButton(onPressed: (){}, icon:Icon(Icons.more_horiz_sharp)),
     //                                    ],
     //                                  ),
     //                                ),
     //                                Container(
     //                                  height:5,
     //                                  color:Colors.black12,
     //                                ),
     //                                SingleChildScrollView(
     //                                  scrollDirection: Axis.vertical,
     //                                  child: FutureBuilder<ApiResponse>(
     //                                    future:_dash.getData(),
     //                                    builder: (context, snapshot) {
     //                                      if (snapshot.hasData) {
     //                                        final apiResponse = snapshot.data!;
     //                                        return SingleChildScrollView(
     //                                          scrollDirection: Axis.horizontal,
     //                                          child: DataTable(
     //                                            columns: [
     //                                              DataColumn(label: Text('ID')),
     //                                              DataColumn(label: Text('Order Date')),
     //                                              DataColumn(label: Text('Invoice No.')),
     //                                              DataColumn(label: Text('Amount')),
     //                                              DataColumn(label: Text('Payment Method')),
     //                                              DataColumn(label: Text('Status')),
     //                                            ],
     //                                            // rows: [
     //                                            //   DataRow(cells: [
     //                                            //     DataCell(Text('${data.id}')),
     //                                            //     DataCell(Text(snapshot.data!.order_date ?? '')),
     //                                            //     DataCell(Text(snapshot.data!.invoice_no ?? '')),
     //                                            //     DataCell(Text(snapshot.data!.amount.toString())),
     //                                            //     DataCell(Text(snapshot.data!.payment_method ?? '')),
     //                                            //     DataCell(Text(snapshot.data!.status ?? '')),
     //                                            //   ]),
     //                                            // ],
     //                                            rows:apiResponse.data
     //                                                .map((data) => DataRow(cells: [
     //                                              DataCell(Text('${data.id}')),
     //                                              DataCell(Text('${data.orderDate}')),
     //                                              DataCell(Text('${data.invoiceNo}')),
     //                                              DataCell(Text('${data.amount}')),
     //                                              DataCell(Text('${data.paymentMethod}')),
     //                                              DataCell(Text('${data.status}')),
     //                                            ]))
     //                                                .toList(),
     //                                          ),
     //                                          );
     //
     //                                      } else if (snapshot.hasError) {
     //                                        print(snapshot.hasError);
     //                                        return Lottie.network("https://assets10.lottiefiles.com/packages/lf20_5saci4q5.json");
     //                                      } else {
     //                                        return Center(child: CircularProgressIndicator());
     //                                      }
     //                                    },
     //                                  ),
     //                                ),
     //                              ],
     //                            )
     //                        )
     //                      ],
     //                    ),
     //                  );
     //
     //                }
     //                else if (snapshot.hasError) {
     //                  print(snapshot.error);
     //                  return Center(
     //                    child: Column(
     //                      children: [
     //
     //                        Lottie.network("https://assets3.lottiefiles.com/packages/lf20_JUr2Xt.json",width: double.infinity,fit:BoxFit.fill),
     //                        Text('No Internet Connection',style: TextStyle(fontSize: 22,color:Colors.red),),
     //
     //                      ],
     //                    ),
     //                  );
     //                }
     //                return const Center(
     //                  child: CircularProgressIndicator(),
     //                );
     //              },
     //            ),
     //
     //          ],
     //        ),
     //      ),
     //    ),
     //  ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor:Colors.deepOrangeAccent,
            icon: Icon(Icons.home),
            label: 'Home Page',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: 'Category Page',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/images/new-product.png"),color: Colors.red,
              size:50,),
            label: 'Products  Page',
          ),
          BottomNavigationBarItem(
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
