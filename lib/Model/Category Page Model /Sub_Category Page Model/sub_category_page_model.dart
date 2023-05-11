
class SubCategoryApiResponse {
  String message;
  int total;
  List<Data> data;
  SubCategoryApiResponse({required this.total,required this.message,required this.data,});

  factory SubCategoryApiResponse.fromJson(Map<String, dynamic> json) {
    final dataList = json['data'] as List<dynamic>;
    final data = dataList.map((item) => Data.fromJson(item)).toList();
    print(data);

    return SubCategoryApiResponse(
      message: json['message'],
      total:json['total'],
      data: data,
    );
  }
}

class Data {
  int? id;
  String? category;
  String? subcategory_name;
  String? subcategory_slug;


  Data({
    this.id,
    this.category,
    this.subcategory_name,
    this.subcategory_slug,

  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      category: json['category'],
     subcategory_name: json['subcategory_name'],
      subcategory_slug: json['subcategory_slug'],


    );
  }
}
