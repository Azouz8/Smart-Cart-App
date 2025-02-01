import 'package:smart_cart_app/features/home/data/models/cart_product_model/cart_product_model.dart';

abstract class HomeStates {}

class HomeInitial extends HomeStates {}

class HomeAddUserToCartLoading extends HomeStates {}

class HomeAddUserToCartFailure extends HomeStates {}

class HomeAddUserToCartSuccess extends HomeStates {}

class HomeRemoveUserFromCartLoading extends HomeStates {}

class HomeRemoveUserFromCartFailure extends HomeStates {}

class HomeRemoveUserFromCartSuccess extends HomeStates {}

class HomeUserNotConnectedToCartState extends HomeStates {}

class HomeGetScannedProductsLoading extends HomeStates {}

class HomeGetScannedProductsFailure extends HomeStates {}

class HomeGetScannedProductsSuccess extends HomeStates {
  List<CartProductModel> products;
  HomeGetScannedProductsSuccess(this.products);
}

class HomeGetCartProductsLoading extends HomeStates {}

class HomeGetCartProductsFailure extends HomeStates {}

class HomeGetCartProductsSuccess extends HomeStates {
  List<CartProductModel> products;
  HomeGetCartProductsSuccess(this.products);
}

class HomeDeleteProductLoading extends HomeStates {}

class HomeDeleteProductFailure extends HomeStates {}

class HomeDeleteProductSuccess extends HomeStates {}
