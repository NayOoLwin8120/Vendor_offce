import 'package:dio/dio.dart';

import 'package:vendor/Model/Category%20Page%20Model%20/category_page_model.dart';


class CategoryApiController {
  final _baseUrl = 'http://192.168.2.106:9999/api/vendor';
  final _endpoint='category';
  final Dio _dio = Dio();

  Future<CategoryApiResponse> getData() async {
    final response = await _dio.get('$_baseUrl/$_endpoint');

    if (response.statusCode == 200) {
      return CategoryApiResponse.fromJson(response.data);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> editCategory({
    required int id,
    required String name,
    required String imageUrl,

  }) async {
    try {
      final response = await _dio.put(
        '$_baseUrl/$_endpoint/$id?_method=put',
        data: {
          'category_name': name,
          'category_image': imageUrl,

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
  Future<void> deleteCategory(int? id) async {
    try {
      await _dio.delete('$_baseUrl/$_endpoint/$id');
      getData();



    } on DioError catch (e) {
      print('Error deleting brand: ${e.message}');
    }
  }
}