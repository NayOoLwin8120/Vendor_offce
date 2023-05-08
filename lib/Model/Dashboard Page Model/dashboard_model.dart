//
//
//
//
//
//
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//
// class DashboardData {
//   String? error;
//   String? message;
//   int? monthly_Sale;
//   int? yearly_sale;
//   int? today_sale;
//   int? id;
//   String? order_date;
//   String? invoice_no;
//   int? amount;
//   String? payment_method;
//   String? status;
//
//   DashboardData({
//      this.error,
//      this.message,
//     this.monthly_Sale,
//     this.yearly_sale,
//     this.today_sale,
//     this.id,
//     this.order_date,
//     this.invoice_no,
//     this.amount,
//     this.payment_method,
//     this.status,
//   });
//
//
//   factory  DashboardData.fromJson(Map<String, dynamic> json) {
//     List<dynamic> data = json['data'];
//     List<DashboardData> dataList = [];
//     data.forEach((item) {
//       var dashboardData = DashboardData(
//         error: json['error'],
//         message: json['message'],
//         monthly_Sale: json['monthly_Sale'] ?? 0,
//         yearly_sale: json['yearly_Sale'] ?? 0,
//         today_sale: json['today_Sale'] ?? 0,
//         id: item['id'],
//         order_date: item['order_date'],
//         invoice_no: item['invoice_no'],
//         amount: item['amount'],
//         payment_method: item['payment_method'],
//         status: item['status'],
//       );
//       dataList.add(dashboardData);
//     });
//
//     print(dataList.first);
//
//       return dataList.first;
//
//
//     }
//
// }
//


class ApiResponse {
   String? error;
   String? message;
   int? monthly_Sale;
   int? yearly_Sale;
  int? today_Sale;
   List<Data> data;
   int? total;

  ApiResponse({
    this.error,
    this.message,
    this.monthly_Sale,
     this.yearly_Sale,
    this.today_Sale,
     required this.data,
   this.total,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    final dataList = json['data'] as List<dynamic>;
    final data = dataList.map((item) => Data.fromJson(item)).toList();
    print(data);

    return ApiResponse(
      error: json['error'],
      message: json['message'],
      monthly_Sale: json['monthly_Sale'] ?? 0,
      yearly_Sale: json['yearly_Sale'] ?? 0,
      today_Sale: json['today_Sale'] ?? 0,
      data: data,
      total: json['total'],
    );
  }
}

class Data {
   int? id;
   String? orderDate;
  String? invoiceNo;
   int? amount;
   String? paymentMethod;
   String? status;

  Data({
    this.id,
     this.orderDate,
    this.invoiceNo,
    this.amount,
     this.paymentMethod,
   this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      orderDate: json['order_date'],
      invoiceNo: json['invoice_no'],
      amount: json['amount'],
      paymentMethod: json['payment_method'],
      status: json['status'],
    );
  }
}
