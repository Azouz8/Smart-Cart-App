import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cart_app/features/home/presentation/manager/home_cubit/home_states.dart';
import 'package:smart_cart_app/features/home/presentation/views/cart_view.dart';
import 'package:smart_cart_app/features/home/presentation/views/map_view.dart';
import 'package:smart_cart_app/features/home/presentation/views/profile_view.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart),
      label: "Cart",
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
    const MapView(),
    const ProfileView()
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(HomeChangeBottomNavState());
  }
}
