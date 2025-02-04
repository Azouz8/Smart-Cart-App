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
    final cubit = HomeCubit.get(context);
    final cartId = CacheHelper.getString(key: CacheHelperKeys.cartID);

    if (cartId != null) {
      cubit.getCartProducts(cartId);
    }

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is HomeAddUserToCartSuccess) {
          cubit.getCartProducts(cubit.cartId);
        }
      },
      builder: (BuildContext context, state) {
        if (state is HomeInitial || state is HomeRemoveUserFromCartSuccess) {
          return const NotConnectedWidget(showSnackbar: false);
        }

        if (state is HomeAddUserToCartFailure) {
          return const NotConnectedWidget(showSnackbar: true);
        }
        if (state is HomeGetCartProductsSuccess ||
            state is HomeDeleteProductSuccess ||
            state is HomeGetScannedProductsSuccess) {
          if (cubit.cartProducts.isEmpty) {
            return const EmptyCartWidget();
          } else {
            return NotEmptyCartWidget(products: cubit.cartProducts);
          }
        }
        return const Center(
          child: CircularProgressIndicator(color: AppColorsLight.primaryColor),
        );
      },
    );
  }
}
