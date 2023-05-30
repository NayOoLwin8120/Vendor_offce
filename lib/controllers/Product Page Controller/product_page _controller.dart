import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:vendor/Model/Product%20Page%20Model/product_page_model.dart';


class ProductApiController {
  // final _baseUrl = 'https://ziizii.mickhae.com/api/vendor';
  final _baseUrl = 'https://ziizii.mickhae.com/api/vendor';
  final _endpoint='products';
  final Dio _dio = Dio();
  final storage=FlutterSecureStorage();


  Future<String?> getVendorId() async {
    String? vendorId = await storage.read(key:'id');
    return vendorId;
  }

  Future<ProductApiResponse> getData() async {
    String? vendorId = await getVendorId();
    final response = await _dio.get('$_baseUrl/$_endpoint/$vendorId');

    if (response.statusCode == 200) {
      print(ProductApiResponse.fromJson(response.data));

      return ProductApiResponse.fromJson(response.data);
    } else {
      throw Exception('Failed to load data');
    }
  }

  List<Dataproduct> filterData(String query, List<Dataproduct> data) {
    final lowercaseQuery = query.toLowerCase();

    return data.where((item) {
      final name = item.name?.toLowerCase() ?? '';
      return name.contains(lowercaseQuery);
    }).toList();
  }



  Future<void> deleteProduct(int? id) async {
    try {
      await _dio.delete('$_baseUrl/$_endpoint/$id');
      getData();
    } on DioError catch (e) {
      print('Error deleting brand: ${e.message}');
    }
  }

}