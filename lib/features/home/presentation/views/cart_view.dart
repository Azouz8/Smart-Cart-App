import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cart_app/core/services/cache_helper.dart';
import 'package:smart_cart_app/core/services/cache_helper_consts.dart';
import 'package:smart_cart_app/core/themes/light_theme/app_colors_light.dart';
import 'package:smart_cart_app/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:smart_cart_app/features/home/presentation/manager/home_cubit/home_states.dart';
import 'widgets/empty_cart_widget.dart';
import 'widgets/not_connected_widget.dart';
import 'widgets/not_empty_cart_widget.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});
  @override
  Widget build(BuildContext context) {
    CacheHelper.remove(key: CacheHelperKeys.cartID);
    if (CacheHelper.getString(key: CacheHelperKeys.cartID) != null) {
      HomeCubit.get(context)
          .getCartProducts(CacheHelper.getString(key: CacheHelperKeys.cartID)!);
    }
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (BuildContext context, state) {
        var cubit = HomeCubit.get(context);
        return SafeArea(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if (state is HomeInitial) {
                return const NotConnectedWidget(showSnackbar: false);
              } else if (state is HomeAddUserToCartFailure) {
                return const NotConnectedWidget(showSnackbar: true);
              } else if (state is HomeAddUserToCartSuccess) {
                cubit.getCartProducts(cubit.cartId);
                cubit.initSocket();
                return Container();
              } else if (state is HomeGetCartProductsSuccess) {
                if (state.products.isEmpty) {
                  return const EmptyCartWidget();
                } else {
                  return NotEmptyCartWidget(products: cubit.cartProducts);
                }
              } else if (state is HomeGetScannedProductsSuccess) {
                return NotEmptyCartWidget(products: state.products);
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                      color: AppColorsLight.primaryColor),
                );
              }
            },
          ),
        );
      },
    );
  }
}
