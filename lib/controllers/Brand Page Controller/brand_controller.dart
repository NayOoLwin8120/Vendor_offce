import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vendor/Model/Brand%20Page%20Model%20/brand_model.dart';


class BrandApiController {
   final _baseUrl = 'http://192.168.2.106:9999/api/vendor';
  final Dio _dio = Dio();

  Future<BrandApiResponse> getData() async {
    final response = await _dio.get('$_baseUrl/brand');

    if (response.statusCode == 200) {
      return BrandApiResponse.fromJson(response.data);
    } else {
      throw Exception('Failed to load data');
    }
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