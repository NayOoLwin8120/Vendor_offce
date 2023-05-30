
class ProductApiResponse {
  String message;
  int total;
  List<Dataproduct> data;
  ProductApiResponse({required this.total,required this.message,required this.data,});

  factory ProductApiResponse.fromJson(Map<String, dynamic> json) {
    final dataList = json['data'] as List<dynamic>;
    final data = dataList.map((item) => Dataproduct.fromJson(item)).toList();
    print(data);

    return ProductApiResponse(
      message: json['message'],
      total:json['total'],
      data: data,
    );
  }
}

class Dataproduct {
  int? id;
  String? name;
  String? product_slug;
  String? product_code;
  int? product_qty;
  List<String?>? product_tags;
  List<String?>? product_size;
 List<String?>? product_color;
  int? selling_price;
  int? discount_price;
  String? short_descp;
  String? long_descp;
  String? product_thambnail;
  int? hot_deals;
  int? featured;
  int? special_offer;
  int? special_deals;
  int? status;
  String? vendor;
  int? vendor_id;
  String? brand;
  String? category;
  String? subcategory;
  List<String?>? multi_images;


  Dataproduct({
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
    this.subcategory,
    this.multi_images,
  });

  factory Dataproduct.fromJson(Map<String, dynamic> json) {
    return Dataproduct(
      id: json['id'],
      name: json['name'],
      product_slug: json['product_slug'],
      product_code: json['product_code'],
      product_qty: json['product_qty'],
      product_tags: (json['product_tags'] as List<dynamic>).cast<String?>(),
      product_size: (json['product_size']as List<dynamic>).cast<String>(),
      product_color:  (json['product_color']as List<dynamic>).cast<String>(),
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
      brand: json['brand'],
        multi_images:(json['multi_images']as List<dynamic>).cast<String>(),



    );
  }
}
