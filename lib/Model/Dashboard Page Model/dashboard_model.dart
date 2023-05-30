


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
    final dataList = json['data']['data'] as List<dynamic>;
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
