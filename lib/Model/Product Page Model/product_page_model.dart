
class ProductApiResponse {
  String message;
  int total;
  List<Data> data;
  ProductApiResponse({required this.total,required this.message,required this.data,});

  factory ProductApiResponse.fromJson(Map<String, dynamic> json) {
    final dataList = json['data'] as List<dynamic>;
    final data = dataList.map((item) => Data.fromJson(item)).toList();
    print(data);

    return ProductApiResponse(
      message: json['message'],
      total:json['total'],
      data: data,
    );
  }
}

class Data {
  int? id;
  String? name;
  String? product_slug;
  String? product_code;
  String? product_qty;
  String? product_tags;
  String? product_size;
  String? product_color;
  String? selling_price;
  String? discount_price;
  String? short_descp;
  String? long_descp;
  String? product_thambnail;
  int? hot_deals;
  int? featured;
  int? special_offer;
  int? special_deals;
  int? status;
  String? vendor;
  String? brand;
  String? category;
  String? subcategory;


  Data({
    this.id,
    this.name,
    this.product_slug,
    this.product_code,
    this.product_qty,
    this.product_tags,
    this.product_size,
    this.product_color,
    this.selling_price,
    this.discount_price,
    this.short_descp,
    this.long_descp,
    this.product_thambnail,
    this.hot_deals,
    this.featured,
    this.special_offer,
    this.special_deals,
    this.status,
    this.vendor,
    this.brand,
    this.category,
    this.subcategory
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      name: json['name'],
      product_slug: json['product_slug'],
      product_code: json['product_code'],
      product_qty: json['product_qty'],
      product_tags: json['product_tags'],
      product_size: json['product_size'],
      product_color: json['product_color'],
      selling_price: json['selling_price'],
      discount_price: json['discount_price'],
      short_descp: json['short_descp'],
      long_descp: json['long_descp'],
      product_thambnail: json['product_thambnail'],
      hot_deals: json['hot_deals'],
      featured: json['featured'],
      special_offer: json['special_offer'],
      special_deals: json['special_deals'],
      status: json['status'],
      vendor: json['vendor'],
      category: json['category'],
      subcategory: json['subcategory'],


    );
  }
}
