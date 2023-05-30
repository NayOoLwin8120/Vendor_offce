
import 'package:vendor/Model/Category%20Page%20Model%20/category_page_model.dart';

class SubCategoryApiResponse {
  String message;
  int total;
  List<Datasubcategory> data;
  SubCategoryApiResponse({required this.total,required this.message,required this.data,});

  factory SubCategoryApiResponse.fromJson(Map<String, dynamic> json) {
    final dataList = json['data'] as List<dynamic>;
    final data = dataList.map((item) => Datasubcategory.fromJson(item)).toList();
    print(data);

    return SubCategoryApiResponse(
      message: json['message'],
      total:json['total'],
      data: data,
    );
  }
}

class Datasubcategory {
  int? id;
  String? category;
  String? subcategory_name;
  String? subcategory_slug;


  Datasubcategory({
    this.id,
    this.category,
    this.subcategory_name,
    this.subcategory_slug,

  });

  factory Datasubcategory.fromJson(Map<String, dynamic> json) {
    return Datasubcategory(
      id: json['id'],
      category: json['category'],
     subcategory_name: json['subcategory_name'],
      subcategory_slug: json['subcategory_slug'],


    );
  }
}
