class RatingModel {
  RatingModel({
    String? productID,
    String? orderID,
    int? userRating,
  }) {
    _productID = productID;
    _orderID = orderID;
    _userRating = userRating;
  }

  RatingModel.fromJson(dynamic json) {
    _productID = json['productID'];
    _orderID = json['orderID'];
    _userRating = json['userRating'];
  }

  String? _productID;
  String? _orderID;
  int? _userRating;

  String? get productID => _productID;

  String? get orderID => _orderID;

  int? get userRating => _userRating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productID'] = _productID;
    map['orderID'] = _orderID;
    map['userRating'] = _userRating;
    return map;
  }
}
