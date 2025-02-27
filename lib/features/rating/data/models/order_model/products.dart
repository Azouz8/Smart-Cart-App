class Products {
  Products({
    String? productID,
    String? title,
    String? image,
    int? quantity,
  }) {
    _productID = productID;
    _title = title;
    _image = image;
    _quantity = quantity;
  }

  Products.fromJson(dynamic json) {
    _productID = json['productID'];
    _title = json['title'];
    _image = json['image'];
    _quantity = json['quantity'];
  }

  String? _productID;
  String? _title;
  String? _image;
  int? _quantity;

  String? get productID => _productID;

  String? get title => _title;

  String? get image => _image;

  int? get quantity => _quantity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productID'] = _productID;
    map['title'] = _title;
    map['image'] = _image;
    map['quantity'] = _quantity;
    return map;
  }
}
