class NewRequest {
  NewRequest({
    this.orderType,
    this.name,
    this.phoneNumber,
    this.location,
    this.note,
    this.pharmacyId,
    this.distributorId,
    this.pharmacyBranchId,
    this.items,
  });
  int? orderType;
  String? name;
  String? phoneNumber;
  String? location;
  String? note;
  int? pharmacyId;
  int? distributorId;
  int? pharmacyBranchId;
  List<Items>? items;

  NewRequest.fromJson(Map<String, dynamic> json) {
    orderType = json['order_type'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    location = json['location'];
    note = json['note'];
    pharmacyId = json['pharmacy_id'];
    distributorId = json['distributor_id'];
    pharmacyBranchId = json['pharmacy_branch_id'];
    items = List.from(json['items']).map((e) => Items.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['order_type'] = orderType;
    _data['name'] = name;
    _data['phone_number'] = phoneNumber;
    _data['location'] = location;
    _data['note'] = note;
    _data['pharmacy_id'] = pharmacyId;
    _data['distributor_id'] = distributorId;
    _data['pharmacy_branch_id'] = pharmacyBranchId;
    _data['items'] = items!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Items {
  Items({
    this.productId,
    this.qty,
  });
  int? productId;
  int? qty;

  Items.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product_id'] = productId;
    _data['qty'] = qty;
    return _data;
  }
}
