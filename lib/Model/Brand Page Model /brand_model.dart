


class BrandApiResponse {
  List<Data> data;
  BrandApiResponse({required this.data,});

  factory BrandApiResponse.fromJson(Map<String, dynamic> json) {
    final dataList = json['data'] as List<dynamic>;
    final data = dataList.map((item) => Data.fromJson(item)).toList();
    print(data);

    return BrandApiResponse(
      data: data,
    );
  }
}

class Data {
  int? id;
  String? brand_name;
  String? brand_slug;
  String? brand_image;
  int? status;
  String? created_at;
  String? updated_at;

  Data({
    this.id,
    this.brand_name,
    this.brand_slug,
    this.brand_image,
    this.status,
    this.created_at,
    this.updated_at,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      brand_name: json['brand_name'],
      brand_slug: json['brand_slug'],
      brand_image: json['brand_image'],
      status: json['status'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],

    );
  }
}
