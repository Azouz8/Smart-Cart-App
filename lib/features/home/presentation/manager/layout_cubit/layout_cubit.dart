import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cart_app/features/home/presentation/views/cart_view.dart';
import 'package:smart_cart_app/features/home/presentation/views/map_view.dart';
import 'package:smart_cart_app/features/home/presentation/views/offers_view.dart';
import 'package:smart_cart_app/features/home/presentation/views/profile_view.dart';

import 'layout_states.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitial());
  static LayoutCubit get(context) => BlocProvider.of(context);

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
    const CartView(),
    const OffersView(),
    const MapView(),
    const ProfileView()
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(LayoutChangeBottomNavState());
  }
}
