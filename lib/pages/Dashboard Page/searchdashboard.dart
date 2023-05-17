import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../Model/Dashboard Page Model/dashboard_model.dart';
import '../../authentication/models/user_detail_model.dart';
import '../../controllers/Dashboard Page Controller/dashboard_controller.dart';

class SearchDashboard  extends SearchDelegate{
  final ApiController _dash=ApiController();
  final userModel = UserModel();
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {

   return FutureBuilder<ApiResponse>(

     future:_dash.getData(),
     builder: (context, snapshot) {
       if (snapshot.hasData) {
         final query = this.query;
         final apiResponse = snapshot.data!;
         final dashs = snapshot.data!.data;

         final filtereddashs = _dash.filterData(query,dashs);
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
         if(filtereddashs.isEmpty){
           return Center(child: Text("No Data Found !",style: TextStyle(fontSize: 26),));
         }
         return SingleChildScrollView(
           scrollDirection: Axis.horizontal,
           child: DataTable(
             columns: [
               DataColumn(label: Text('Sl')),
               DataColumn(label: Text('Order Date')),
               DataColumn(label: Text('Invoice No.')),

             ],



             rows: filtereddashs.map((data) {
               int sl = filtereddashs.indexOf(data) + 1; // Calculate the Sl value
               return DataRow(cells: [
                 DataCell(Text('$sl')),
                 DataCell(Text('${data.orderDate}')),
                 DataCell(Text('${data.invoiceNo}')),

               ]);
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
   );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Text("Search Order ");
  }

}