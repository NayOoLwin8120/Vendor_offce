// import 'package:dio/dio.dart';
import 'package:vendor/Model/Dashboard%20Page%20Model/dashboard_model.dart';
//
// class DashboardController {
//
//   Future<DashboardData> getDashboardData() async {
//     try {
//       final response = await Dio().get('http://192.168.2.106:9999/api/vendor/dashboard/1');
//
//
//
//       return DashboardData.fromJson(response.data);
//
//
//     } catch (e) {
//       print(e);
//       throw Exception('Failed to get dashboard: $e');
//     }
//   }
// }

import 'package:dio/dio.dart';

class ApiController {
  static final _baseUrl = 'http://192.168.2.106:9999/api/vendor';
  final Dio _dio = Dio();

  Future<ApiResponse> getData() async {
    final response = await _dio.get('$_baseUrl/dashboard/1');

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(response.data);
    } else {
      throw Exception('Failed to load data');
    }
  }
}