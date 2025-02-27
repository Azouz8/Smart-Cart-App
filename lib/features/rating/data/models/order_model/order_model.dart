import 'products.dart';

class OrderModel {
  OrderModel({
    String? orderID,
    String? date,
    String? totalPrice,
    List<Products>? products,
  }) {
    _orderID = orderID;
    _date = date;
    _totalPrice = totalPrice;
    _products = products;
  }

  OrderModel.fromJson(dynamic json) {
    _orderID = json['orderID'];
    _date = json['date'];
    _totalPrice = json['totalPrice'];
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products?.add(Products.fromJson(v));
      });
    }
  }

  String? _orderID;
  String? _date;
  String? _totalPrice;
  List<Products>? _products;

  String? get orderID => _orderID;

  String? get date => _date;

  String? get totalPrice => _totalPrice;

  List<Products>? get products => _products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['orderID'] = _orderID;
    map['date'] = _date;
    map['totalPrice'] = _totalPrice;
    if (_products != null) {
      map['products'] = _products?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
