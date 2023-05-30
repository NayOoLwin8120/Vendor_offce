


class BrandApiResponse {
  List<Databrand> data;
  BrandApiResponse({required this.data,});

  factory BrandApiResponse.fromJson(Map<String, dynamic> json) {
    final dataList = json['data']['data'] as List<dynamic>;
    final data = dataList.map((item) => Databrand.fromJson(item)).toList();
    print(data);

    return BrandApiResponse(
      data: data,
    );
  }
}

class Databrand {
  int? id;
  String? brand_name;
  String? brand_slug;
  String? brand_image;
  int? status;
  String? created_at;
  String? updated_at;

  Databrand({
    this.id,
    this.brand_name,
    this.brand_slug,
    this.brand_image,
    this.status,
    this.created_at,
    this.updated_at,
  });

  factory Databrand.fromJson(Map<String, dynamic> json) {
    return Databrand(
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
