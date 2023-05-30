import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vendor/Model/Brand%20Page%20Model%20/brand_model.dart';


class BrandApiController {

  final ipaddress="https://ziizii.mickhae.com/";
  final ipaddress2='http://192.168.100.23:9999/';
  final ipaddress3='http://192.168.100.23:9999/';
  final ipaddress4='http://192.168.100.23:8888/';
  // final _baseUrl = 'https://ziizii.mickhae.com/api/vendor';
  final _baseUrl = 'https://ziizii.mickhae.com/api/vendor';


  final Dio _dio = Dio();

  Future<BrandApiResponse> getData() async {

    final response = await _dio.get('$_baseUrl/brand');

    if (response.statusCode == 200) {
      return BrandApiResponse.fromJson(response.data);
    } else {
      throw Exception('Failed to load data');
    }
  }

   List<Databrand> filterData(String query, List<Databrand> data) {
     final lowercaseQuery = query.toLowerCase();

     return data.where((item) {
       final name = item.brand_name?.toLowerCase() ?? '';
       return name.contains(lowercaseQuery);
     }).toList();
   }

  Future<void> editBrand({
    required int id,
    required String name,
    required String imageUrl,

  }) async {
    try {

      final response = await _dio.put(
        '$_baseUrl/brand/$id',
        data: {
          'brand_name': name,
          'brand_image': imageUrl,

        },
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        // Success
        print('Brand updated successfully!');

      } else {
        // Error

        print('Error updating brand');
      }
    } catch (error) {
      // Handle error
      print('Error updating brand: ${error.toString()}');
    }
  }
  Future<void> deleteBrand(int? id) async {
    try {

      await _dio.delete('$_baseUrl/brand/$id');
      getData();



    } on DioError catch (e) {
      print('Error deleting brand: ${e.message}');
    }
  }
}