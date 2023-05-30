import 'package:dio/dio.dart';
import 'package:vendor/Model/Category%20Page%20Model%20/Sub_Category%20Page%20Model/sub_category_page_model.dart';

// import 'package:vendor/Model/Category%20Page%20Model%20/category_page_model.dart';


class SubCategoryApiController {
  // final _baseUrl = 'https://ziizii.mickhae.com/api/vendor';
  final _baseUrl = 'https://ziizii.mickhae.com/api/vendor';
  final _endpoint='subcategory';
  final Dio _dio = Dio();

  Future<SubCategoryApiResponse> getData() async {
    final response = await _dio.get('$_baseUrl/$_endpoint');

    if (response.statusCode == 200) {
      return SubCategoryApiResponse.fromJson(response.data);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> updateSubCategory(int subcategoryId, String subcategoryName, int categoryId) async {
    try {
      final response = await _dio.put(
        '$_baseUrl/$_endpoint/$subcategoryId',
        data: {
          'subcategory_name': subcategoryName,
          'category_id': categoryId,
        },
      );
      print(response.data);
    } catch (error) {
      print(error);
    }
  }


  List<Datasubcategory> filterData(String query, List<Datasubcategory> data) {
    final lowercaseQuery = query.toLowerCase();

    return data.where((item) {
      final name = item.subcategory_name?.toLowerCase() ?? '';
      return name.contains(lowercaseQuery);
    }).toList();
  }

  Future<void> editSubCategory({
    required int id,

    required String categoryId, // Add categoryId parameter
    required String subcategoryName, // Add categoryName parameter
  }) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/$_endpoint/$id?_method=put',
        data: {
          'subcategory_name': subcategoryName,
          'category_id': categoryId, // Use categoryId parameter to update the subcategory record
        },
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        // Success
        print('Subcategory updated successfully!');

        // Update category name if provided
        if (subcategoryName.isNotEmpty) {
          await _dio.put(
            '$_baseUrl/category/$categoryId?_method=put',
            data: {
              'category_name': subcategoryName,
            },
          );
          print('Category name updated successfully!');
        }
      } else {
        // Error
        print('Error updating subcategory');
      }
    } catch (error) {
      // Handle error
      print('Error updating subcategory: ${error.toString()}');
    }
  }
  Future<void> deleteSubCategory(int? id) async {
    try {
      await _dio.delete('$_baseUrl/$_endpoint/$id');
      getData();



    } on DioError catch (e) {
      print('Error deleting brand: ${e.message}');
    }
  }
}