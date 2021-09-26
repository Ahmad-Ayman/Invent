class NewRequestResponseModel {
  NewRequestResponseModel({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });
  late final int code;
  late final String status;
  late final String message;
  late final Data data;

  NewRequestResponseModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['status'] = status;
    _data['message'] = message;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.status,
    required this.grandTotal,
    required this.netTotal,
    required this.taxAmount,
    required this.itemCount,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.name,
    required this.phoneNumber,
    required this.location,
    required this.addedBy,
    required this.pharmacyId,
    required this.distributorId,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
    required this.items,
  });
  late final String status;
  late final int grandTotal;
  late final int netTotal;
  late final int taxAmount;
  late final int itemCount;
  late final int paymentStatus;
  late final String paymentMethod;
  late final String name;
  late final String phoneNumber;
  late final String location;
  late final int addedBy;
  late final int pharmacyId;
  late final int distributorId;
  late final String updatedAt;
  late final String createdAt;
  late final int id;
  late final List<ItemsNewRequestResponse> items;

  Data.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    grandTotal = json['grand_total'];
    netTotal = json['net_total'];
    taxAmount = json['tax_amount'];
    itemCount = json['item_count'];
    paymentStatus = json['payment_status'];
    paymentMethod = json['payment_method'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    location = json['location'];
    addedBy = json['added_by'];
    pharmacyId = json['pharmacy_id'];
    distributorId = json['distributor_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    items = List.from(json['items']).map((e) => ItemsNewRequestResponse.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['grand_total'] = grandTotal;
    _data['net_total'] = netTotal;
    _data['tax_amount'] = taxAmount;
    _data['item_count'] = itemCount;
    _data['payment_status'] = paymentStatus;
    _data['payment_method'] = paymentMethod;
    _data['name'] = name;
    _data['phone_number'] = phoneNumber;
    _data['location'] = location;
    _data['added_by'] = addedBy;
    _data['pharmacy_id'] = pharmacyId;
    _data['distributor_id'] = distributorId;
    _data['updated_at'] = updatedAt;
    _data['created_at'] = createdAt;
    _data['id'] = id;
    _data['items'] = items.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ItemsNewRequestResponse {
  ItemsNewRequestResponse({
    required this.id,
    required this.requestId,
    required this.productId,
    required this.quantity,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.generalPrice,
  });
  late final int id;
  late final int requestId;
  late final int productId;
  late final int quantity;
  late final String price;
  late final String createdAt;
  late final String updatedAt;
  late final String generalPrice;

  ItemsNewRequestResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestId = json['request_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    generalPrice = json['general_price'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['request_id'] = requestId;
    _data['product_id'] = productId;
    _data['quantity'] = quantity;
    _data['price'] = price;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['general_price'] = generalPrice;
    return _data;
  }
}
