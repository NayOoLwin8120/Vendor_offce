// Start For Vendor Details
// _____ Start for userdetail ____

// child: InkWell(
//   onTap: () {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//
//         builder: (context) {
//           return FutureBuilder<Map<String, dynamic>?>(
//             future:userModel.getUserData() ,
//             builder: (context,  snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Lottie.network("https://assets6.lottiefiles.com/private_files/lf30_jo7huq2d.json");
//               }
//               else if (snapshot.connectionState == ConnectionState.done) {
//                 final userData = snapshot.data!;
//                 return UserDetailScreen(userData: userData) ;
//                 // return Userdetail() ;
//               }
//               else if (snapshot.hasError){
//                 return Lottie.network('https://assets9.lottiefiles.com/packages/lf20_0hj4Khn1at.json');
//             } else{
//                 return Text("No found");
//               }
//             },
//           );
//         },
//         // builder:(context)=>UserDetailScreen(),
//       ),
//     );
//   },
//   child: ElevatedButton(
//     onPressed: null,
//     child: Text('Show Vendor Deatails'),
//   ),
//
// ),//
//End for Vendor Deatils

// SingleChildScrollView(
//   scrollDirection: Axis.vertical,
//   child: Column(
//     children: [
//       SizedBox(height:20),
//       Container(child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text("Your Vendor Account is ",style: TextStyle(fontSize: 18),),
//           Text("Active ",style: TextStyle(fontSize: 20,color: Colors.green),),
//         ],
//       )),
//       SizedBox(height:20),
//       Text("Vendor Dashboard Data"),
//       SizedBox(height:20),
//       SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Container(
//           child:Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(1.0),
//                 child: Container(
//                   width: 120,
//                   height:100,
//                   color:Colors.green,
//                   child:Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Container(
//                         child: Row(
//                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
//                          children: [
//                            Container(
//                              child:
//                                 Row(
//                                   children: [
//                                     Icon(Icons.monetization_on,size: 18,),
//                                     Text("1200",style: TextStyle(fontSize: 18),),
//                                     Text("USD",style: TextStyle(fontSize: 18),),
//                                   ],
//                                 ),
//                            ),
//                             Icon(Icons.shopping_cart_rounded,size: 18,),
//                          ],
//                         ),
//                       ),
//                       Container(
//                         width:100,
//                         height:3,
//                         color: Colors.black,
//                       ),
//                       Text("Monthly Sale",style: TextStyle(fontSize: 20),)
//
//                     ],
//                   )
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(2.0),
//                 child: Container(
//                     width: 120,
//                     height:100,
//                     color:Colors.green,
//                     child:Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Container(
//                           child: Row(
//                             mainAxisAlignment:MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(
//
//                                 child:
//                                 Row(
//                                   children: [
//                                     Icon(Icons.monetization_on,size: 18,),
//                                     Text("1200",style: TextStyle(fontSize: 18),),
//                                     Text("USD",style: TextStyle(fontSize: 18),),
//                                   ],
//                                 ),
//                               ),
//                               Icon(Icons.shopping_cart_rounded,size: 18,),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           width:100,
//                           height:3,
//                           color: Colors.black,
//                         ),
//                         Text("Monthly Sale",style: TextStyle(fontSize: 20),)
//
//                       ],
//                     )
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(2.0),
//                 child: Container(
//                     width: 120,
//                     height:100,
//                     color:Colors.green,
//                     child:Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Container(
//                           child: Row(
//                             mainAxisAlignment:MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(
//                                 child:
//                                 Row(
//                                   children: [
//                                     Icon(Icons.monetization_on,size: 18,),
//                                     Text("1200",style: TextStyle(fontSize: 18),),
//                                     Text("USD",style: TextStyle(fontSize: 18),),
//                                   ],
//                                 ),
//                               ),
//                               Icon(Icons.shopping_cart_rounded,size: 18,),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           width:100,
//                           height:3,
//                           color: Colors.black,
//                         ),
//                         Text("Monthly Sale",style: TextStyle(fontSize: 20),)
//
//                       ],
//                     )
//                 ),
//               ),
//
//             ],
//           )
//         ),
//       ),
//       SizedBox(height:10),
//       Container(
//         width:double.infinity,
//         height:500,
//         color:Colors.blue,
//         child:Column(
//           children: [
//             Container(
//               color:Colors.white38,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text("Order Summary",style: TextStyle(fontSize: 20),),
//                   IconButton(onPressed: (){}, icon:Icon(Icons.more_horiz_sharp)),
//                 ],
//               ),
//             ),
//             Container(
//               height:5,
//               color:Colors.black12,
//             ),
//             _dataList.isEmpty
//                 //? Center(child: CircularProgressIndicator())
//                 ?SingleChildScrollView(
//                  scrollDirection: Axis.horizontal,
//                   child: DataTable(
//               columns: <DataColumn>[
//                   DataColumn(
//                     label: Text('Order_id',style: TextStyle(fontSize: 18),),
//                     tooltip: 'Order_id',
//                   ),
//                   DataColumn(
//                     label: Text('Product',style: TextStyle(fontSize: 18),),
//                     tooltip: 'Product',
//                   ),
//                   DataColumn(
//                     label: Text('Customer',style: TextStyle(fontSize: 18),),
//                     tooltip: 'Customer',
//                   ),
//                   DataColumn(
//                     label: Text('Order_Date',style: TextStyle(fontSize: 18),),
//                     tooltip: 'Date',
//                   ),
//                   DataColumn(
//                     label: Text('Price',style: TextStyle(fontSize: 18),),
//                     tooltip: 'Price',
//                   ),
//                   DataColumn(
//                     label: Text('Status',style: TextStyle(fontSize: 18),),
//                     tooltip: 'order_status',
//                   ),
//
//
//
//               ],
//               rows: _dataList
//                     .map(
//                       (data) => DataRow(
//                     cells: [
//                       DataCell(
//                         // Text(data['name']),
//                         Text("Name"),
//                       ),
//                       DataCell(
//                         Text(data['age'].toString()),
//                       ),
//                     ],
//                   ),
//               )
//                     .toList(),
//             ),
//                 )
//                 : DataTable(
//               columns: <DataColumn>[
//                 DataColumn(
//                   label: Text('Name'),
//                   tooltip: 'Name',
//                 ),
//                 DataColumn(
//                   label: Text('Age'),
//                   tooltip: 'Age',
//                 ),
//               ],
//               rows: _dataList
//                   .map(
//                     (data) => DataRow(
//                   cells: [
//                     DataCell(
//                       // Text(data['name']),
//                       Text("Name"),
//                     ),
//                     DataCell(
//                       Text(data['age'].toString()),
//                     ),
//                   ],
//                 ),
//               )
//                   .toList(),
//             ),
//           ],
//         )
//       )
//     ],
//   ),
// )