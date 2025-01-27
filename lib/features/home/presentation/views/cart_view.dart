import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cart_app/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:smart_cart_app/features/home/presentation/manager/home_cubit/home_states.dart';
import 'widgets/empty_cart_widget.dart';
import 'widgets/not_connected_widget.dart';
import 'widgets/not_empty_cart_widget.dart';

class CartView extends StatelessWidget {
  CartView({super.key});
  final List<CartItemModel> list = [
    CartItemModel(
      title:
          "1Lorem Ipsum is simply dummy text of the printing and typesetting",
      price: "250",
      quantity: "3",
    ),
    CartItemModel(
      title:
          "2Lorem Ipsum is simply dummy text of the printing and typesetting",
      price: "250",
      quantity: "3",
    ),
    CartItemModel(
      title:
          "3Lorem Ipsum is simply dummy text of the printing and typesetting",
      price: "250",
      quantity: "3",
    ),
    CartItemModel(
      title: "Lorem Ipsum is simply dummy text of the printing and typesetting",
      price: "250",
      quantity: "3",
    ),
    CartItemModel(
      title: "Lorem Ipsum is simply dummy text of the printing and typesetting",
      price: "250",
      quantity: "3",
    ),
    CartItemModel(
      title: "Lorem Ipsum is simply dummy text of the printing and typesetting",
      price: "250",
      quantity: "3",
    ),
    CartItemModel(
      title: "Lorem Ipsum is simply dummy text of the printing and typesetting",
      price: "250",
      quantity: "3",
    ),
    CartItemModel(
      title: "Lorem Ipsum is simply dummy text of the printing and typesetting",
      price: "250",
      quantity: "3",
    ),
    CartItemModel(
      title: "Lorem Ipsum is simply dummy text of the printing and typesetting",
      price: "250",
      quantity: "3",
    ),
    CartItemModel(
      title: "Lorem Ipsum is simply dummy text of the printing and typesetting",
      price: "250",
      quantity: "3",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      builder: (BuildContext context, state) {
        return SafeArea(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if (false) {
                return const NotConnectedWidget();
              } else if (false) {
                return const EmptyCartWidget();
              } else {
                return NotEmptyCartWidget(list: list);
              }
            },
          ),
        );
      },
    );
  }
}

class CartItemModel {
  final String title, price, quantity;

  CartItemModel(
      {required this.title, required this.price, required this.quantity});
}
