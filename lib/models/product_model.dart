class ProductModel {
  ProductModel({
    this.code,
    this.status,
    this.message,
    this.data,
  });
  int? code;
  String? status;
  String? message;
  List<ProductData>? data;

  ProductModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    data = List.from(json['data']).map((e) => ProductData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['status'] = status;
    _data['message'] = message;
    _data['data'] = data!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ProductData {
  ProductData({
    this.id,
    this.name,
    this.price,
    this.description,
    this.confirmed,
    this.categoryId,
    this.stock,
    this.unit,
    this.SKU,
    this.barcode,
    this.productTax,
    this.image,
    this.addedBy,
    this.editedBy,
    this.createdAt,
    this.updatedAt,
  });
  int? id;
  String? name;
  String? price;
  String? description;
  int? confirmed;
  int? categoryId;
  int? stock;
  String? unit;
  String? SKU;
  String? barcode;
  int? productTax;
  String? image;
  int? addedBy;
  int? editedBy;
  String? createdAt;
  String? updatedAt;

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    confirmed = json['confirmed'];
    categoryId = json['category_id'];
    stock = json['stock'];
    unit = json['unit'];
    SKU = json['SKU'];
    barcode = json['barcode'];
    productTax = json['product_tax'];
    image = json['image'];
    addedBy = json['added_by'];
    editedBy = json['edited_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['price'] = price;
    _data['description'] = description;
    _data['confirmed'] = confirmed;
    _data['category_id'] = categoryId;
    _data['stock'] = stock;
    _data['unit'] = unit;
    _data['SKU'] = SKU;
    _data['barcode'] = barcode;
    _data['product_tax'] = productTax;
    _data['image'] = image;
    _data['added_by'] = addedBy;
    _data['edited_by'] = editedBy;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}
