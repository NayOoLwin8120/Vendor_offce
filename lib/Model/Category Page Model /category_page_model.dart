


class CategoryApiResponse {
  String message;
  int total;
  List<Data> data;
  CategoryApiResponse({required this.total,required this.message,required this.data,});

  factory CategoryApiResponse.fromJson(Map<String, dynamic> json) {
    final dataList = json['data'] as List<dynamic>;
    final data = dataList.map((item) => Data.fromJson(item)).toList();
    print(data);

    return CategoryApiResponse(
      message: json['message'],
      total:json['total'],
      data: data,
    );
  }
}

class Data {
  int? id;
  String? category_name;
  String? category_slug;
  String? category_image;
  int? status;
  String? created_at;
  String? updated_at;

  Data({
    this.id,
    this.category_name,
    this.category_slug,
    this.category_image,
    this.status,
    this.created_at,
    this.updated_at,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      category_name: json['brand_name'],
      category_slug: json['brand_slug'],
      category_image: json['brand_image'],
      status: json['status'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],

    );
  }
}