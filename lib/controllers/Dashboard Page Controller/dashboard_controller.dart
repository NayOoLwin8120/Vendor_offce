// import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:vendor/Model/Dashboard%20Page%20Model/dashboard_model.dart';


import 'package:dio/dio.dart';

class ApiController {
  // static final _baseUrl = 'https://ziizii.mickhae.com/api/vendor';
  static final _baseUrl = 'https://ziizii.mickhae.com/api/vendor';
  final Dio _dio = Dio();
  final storage=FlutterSecureStorage();

  Future<ApiResponse> getData() async {
    final response = await _dio.get('$_baseUrl/dashboard/1');

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(response.data);
    } else {
      throw Exception('Failed to load data');
    }
  }
  Future<String?> getVendorStatus() async {
    String? vendorStatus = await storage.read(key:'vendor_status');
    print(vendorStatus.runtimeType);
    print(vendorStatus);
    return vendorStatus;
  }

  List<Data> filterData(String query, List<Data> data) {
    final lowercaseQuery = query.toLowerCase();

    return data.where((item) {
      final name = item.invoiceNo?.toLowerCase() ?? '';
      return name.contains(lowercaseQuery);
    }).toList();
  }
}