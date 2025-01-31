import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cart_app/features/home/data/repos/home_repo.dart';
import 'package:smart_cart_app/features/home/presentation/manager/home_cubit/home_states.dart';
import 'package:smart_cart_app/features/home/presentation/views/cart_view.dart';
import 'package:smart_cart_app/features/home/presentation/views/map_view.dart';
import 'package:smart_cart_app/features/home/presentation/views/offers_view.dart';
import 'package:smart_cart_app/features/home/presentation/views/profile_view.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit(this.homeRepo) : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);
  HomeRepo homeRepo;
  String cartId = "";
  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart),
      label: "Cart",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.redeem_rounded),
      label: "Offers",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.map),
      label: "Map",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: "Profile",
    ),
  ];
  List<Widget> screens = [
    CartView(),
    const OffersView(),
    const MapView(),
    const ProfileView()
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(HomeChangeBottomNavState());
  }

  Future<void> connectUserToCart(String cartID) async {
    emit(HomeAddUserToCartLoading());
    var result =
        await homeRepo.addUserToCart(cartID: cartID, userID: "AzouzUser");
    result.fold((failure) {
      emit(HomeAddUserToCartFailure());
    }, (responseCode) {
      emit(HomeAddUserToCartSuccess());
      cartId = cartID;
    });
  }

  Future<void> getCartProducts(String cartID) async {
    emit(HomeGetCartProductsLoading());
    var result = await homeRepo.getCartProducts(cartID: cartID);
    result.fold((failure) {
      emit(HomeGetCartProductsFailure());
    }, (products) {
      emit(HomeGetCartProductsSuccess(products));
    });
  }
}
