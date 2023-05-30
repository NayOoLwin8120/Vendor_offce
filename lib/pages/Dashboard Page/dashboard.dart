import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:vendor/Model/Dashboard%20Page%20Model/dashboard_model.dart';
import 'package:vendor/authentication/models/user_detail_model.dart';
import 'package:vendor/controllers/Dashboard%20Page%20Controller/dashboard_controller.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final ApiController _dash=ApiController();
  final userModel = UserModel();
  Data? selectedData;


  String? vendorStatus = ApiController().getVendorStatus().toString();



  Color Status(String? userStatus) {
    if (userStatus == "pending") {
      return Colors.red;
    } else {
      return Colors.green;
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scrollbar(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              FutureBuilder<ApiResponse>(
                future:_dash.getData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: Column(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children: [
                          Center(child: Text("Data are Loading")),
                          Center(child: CircularProgressIndicator()),
                        ],
                      ));
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error fetching data'));
                    }
                    final apiResponse = snapshot.data!;

                    return SingleChildScrollView(

                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          SizedBox(height:20),

                          Container(child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Your Vendor Account is ",style: TextStyle(fontSize: 18),),
                              // Text("${vendorStatus}",style: TextStyle(fontSize: 20,color: Colors.green),),
                              FutureBuilder<String?>(
                                future:_dash.getVendorStatus(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Error fetching vendor status');
                                  } else {
                                    String? vendorStatus = snapshot.data;
                                    return Text(
                                      vendorStatus == 'active' ? '$vendorStatus' :' `$vendorStatus` .Please Contact Admin !',
                                      style: TextStyle(fontSize: 20, color:vendorStatus =='active' ? Colors.green : Colors.red),
                                    );
                                  }
                                },
                              ),
                            ],
                          )),
                          SizedBox(height:20),
                          Text("${apiResponse.message}"),
                          SizedBox(height:20),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Container(
                                          width: 120,
                                          height:100,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                            color: Colors.blue,
                                          ),
                                          child:
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(

                                                child: Row(
                                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      child:
                                                      Row(
                                                        children: [
                                                          Icon(Icons.monetization_on,size: 18,),
                                                          Text("${apiResponse.today_Sale.toString()}",style: TextStyle(fontSize: 16,color: Colors.white),),
                                                          Text("USD",style: TextStyle(fontSize: 16,color:Colors.white),),
                                                        ],
                                                      ),
                                                    ),
                                                    Icon(Icons.shopping_cart_rounded,size: 18,),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width:100,
                                                height:3,
                                                color: Colors.black,
                                              ),
                                              Text("Today Sale",style: TextStyle(fontSize: 16,color:Colors.white),)

                                            ],
                                          )
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Container(
                                          width: 120,
                                          height:100,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                            color: Colors.blue,
                                          ),
                                          child:Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                child: Row(
                                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(

                                                      child:
                                                      Row(
                                                        children: [
                                                          Icon(Icons.monetization_on,size: 18,),
                                                          Text("${apiResponse.monthly_Sale.toString()}",style: TextStyle(fontSize: 16,color:Colors.white),),
                                                          Text("USD",style: TextStyle(fontSize: 16,color:Colors.white),),
                                                        ],
                                                      ),
                                                    ),
                                                    Icon(Icons.shopping_cart_rounded,size: 18,),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width:100,
                                                height:3,
                                                color: Colors.black,
                                              ),
                                              Text("Monthly Sale",style: TextStyle(fontSize: 16,color:Colors.white),)

                                            ],
                                          )
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Container(
                                          width: 120,
                                          height:100,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                            color: Colors.blue,
                                          ),
                                          child:Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                child: Row(
                                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      child:
                                                      Row(
                                                        children: [
                                                          Icon(Icons.monetization_on,size: 18,),
                                                          Text("${apiResponse.yearly_Sale.toString()}",style: TextStyle(fontSize: 16,color:Colors.white),),
                                                          Text("USD",style: TextStyle(fontSize: 16,color:Colors.white),),
                                                        ],
                                                      ),
                                                    ),
                                                    Icon(Icons.shopping_cart_rounded,size: 18,),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width:100,
                                                height:3,
                                                color: Colors.black,
                                              ),
                                              Text("Yearly Sale",style: TextStyle(fontSize: 16,color:Colors.white),)

                                            ],
                                          )
                                      ),
                                    ),

                                  ],
                                )
                            ),
                          ),
                          SizedBox(height:10),
                          Container(
                              width:double.infinity,
                              height:500,
                              color:Colors.blue,
                              child:Column(
                                children: [
                                  Container(
                                    color:Colors.white38,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Order Summary",style: TextStyle(fontSize: 20),),
                                        IconButton(onPressed: (){}, icon:Icon(Icons.more_horiz_sharp)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height:5,
                                    color:Colors.black12,
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: FutureBuilder<ApiResponse>(
                                      future:_dash.getData(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          final apiResponse = snapshot.data!;
                                          return SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: DataTable(
                                              columns: [
                                                DataColumn(label: Text('Sl')),
                                                DataColumn(label: Text('Order Date')),
                                                DataColumn(label: Text('Invoice No.')),
                                                DataColumn(label: Text("Action")),
                                                // DataColumn(label: Text('Amount')),
                                                // DataColumn(label: Text('Payment Method')),
                                                // DataColumn(label: Text('Status')),
                                              ],



                                              rows: apiResponse.data.map((data) {
                                                int sl = apiResponse.data.indexOf(data) + 1; // Calculate the Sl value
                                                return DataRow(cells: [
                                                  DataCell(Text('$sl')),
                                                  DataCell(Text('${data.orderDate}')),
                                                  DataCell(Text('${data.invoiceNo}')),
                                                  DataCell(IconButton(
                                                    icon:Icon(Icons.remove_red_eye_outlined),
                                                    onPressed: (){
                                                      showModalBottomSheet(
                                                        context: context,
                                                        builder: (context) => OrderDetailsDialog(orderData: data!),
                                                      );
                                                    },
                                                  )),

                                                ],



                                                //     onSelectChanged: (selected) {
                                                //   setState(() {
                                                //     if (selected!) {
                                                //       selectedData = data; // Store the selected data
                                                //     }
                                                //   });
                                                // },
                                                //   onLongPress:(){
                                                //     showModalBottomSheet(
                                                //       context: context,
                                                //       builder: (context) => OrderDetailsDialog(orderData: selectedData!),
                                                //     );
                                                //   },
                                                );
                                              }).toList(),
                                            ),



                                          );



                                        } else if (snapshot.hasError) {
                                          print(snapshot.hasError);
                                          return Lottie.network("https://assets10.lottiefiles.com/packages/lf20_5saci4q5.json");
                                        } else {
                                          return Center(child: CircularProgressIndicator());
                                        }
                                      },
                                    ),
                                  ),

                                ],
                              )
                          )
                        ],
                      ),
                    );

                  }
                  else if (snapshot.hasError) {
                    print(snapshot.error);
                    return Center(
                      child: Column(
                        children: [

                          Lottie.network("https://assets3.lottiefiles.com/packages/lf20_JUr2Xt.json",width: double.infinity,fit:BoxFit.fill),
                          Text('No Internet Connection',style: TextStyle(fontSize: 22,color:Colors.red),),

                        ],
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class OrderDetailsDialog extends StatelessWidget {
  final Data orderData;

  const OrderDetailsDialog({Key? key, required this.orderData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Order Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            Text('Order ID  :       ${orderData.id}',style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
            SizedBox(height: 20),
            Text('            Order Date      :     ${orderData.orderDate}',style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
            SizedBox(height: 20),
            Text('            Invoice No.     :     ${orderData.invoiceNo}',style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
            SizedBox(height: 20),
            Text('  Amount      :       ${orderData.amount}',style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
            SizedBox(height: 20),
            Text('     Payment     :      ${orderData.paymentMethod}',style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
            SizedBox(height: 20),
            Text('  Order Status    :      ${orderData.status}',style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400,color:orderData.status== 'pending' ? Colors.red : Colors.green)),
            SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Close Details'),
              onPressed: () => Navigator.pop(context),
            ),
            // Add more order details here
          ],
        ),
      ),
    );
  }
}
