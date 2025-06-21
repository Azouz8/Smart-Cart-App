// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:smart_cart_app/core/services/cache_helper.dart';
// import 'package:smart_cart_app/core/services/helper_functions.dart';
// import 'package:smart_cart_app/core/themes/light_theme/app_colors_light.dart';
// import 'package:smart_cart_app/features/home/presentation/manager/home_cubit/home_cubit.dart';
// import 'package:smart_cart_app/features/home/presentation/manager/home_cubit/home_states.dart';
// import 'widgets/empty_cart_widget.dart';
// import 'widgets/not_connected_widget.dart';
// import 'widgets/not_empty_cart_widget.dart';

// class CartView extends StatelessWidget {
//   const CartView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final cubit = HomeCubit.get(context);
//     final cartId = CacheHelper.getString(key: CacheHelperKeys.cartID);

//     if (cartId != null) {
//       cubit.getCartProducts(cartId);
//     }

//     return BlocConsumer<HomeCubit, HomeStates>(
//       listener: (context, state) {
//         if (state is HomeAddUserToCartSuccess) {
//           cubit.getCartProducts(cubit.cartId);
//         }
//         if (state is HomeAddUserToCartFailure) {
//           showCustomSnackBar(
//               context: context, message: state.errMessage, vPadding: 16);
//         } else if (state is HomeDeleteProductFailure) {
//           showCustomSnackBar(
//               context: context, message: state.errMessage, vPadding: 16);
//         } else if (state is HomeGetCartProductsFailure) {
//           showCustomSnackBar(
//               context: context, message: state.errMessage, vPadding: 16);
//         } else if (state is HomeGetScannedProductsFailure) {
//           showCustomSnackBar(
//               context: context, message: state.errMessage, vPadding: 16);
//         } else if (state is HomeRemoveUserFromCartFailure) {
//           showCustomSnackBar(
//               context: context, message: state.errMessage, vPadding: 16);
//         }
//       },
//       builder: (BuildContext context, state) {
//         if (state is HomeInitial || state is HomeRemoveUserFromCartSuccess) {
//           return const NotConnectedWidget(showSnackbar: false);
//         }
//         if (state is HomeAddUserToCartFailure) {
//           return const NotConnectedWidget(
//             showSnackbar: false,
//           );
//         }
//         if (state is HomeGetCartProductsSuccess ||
//             state is HomeDeleteProductSuccess ||
//             state is HomeGetScannedProductsSuccess) {
//           if (cubit.cartProducts.isEmpty) {
//             return const EmptyCartWidget();
//           } else {
//             return NotEmptyCartWidget(products: cubit.cartProducts);
//           }
//         }
//         return const Center(
//           child: CircularProgressIndicator(color: AppColorsLight.primaryColor),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cart_app/core/services/cache_helper.dart';
import 'package:smart_cart_app/core/services/helper_functions.dart';
import 'package:smart_cart_app/core/themes/light_theme/app_colors_light.dart';
import 'package:smart_cart_app/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:smart_cart_app/features/home/presentation/manager/home_cubit/home_states.dart';
import 'widgets/empty_cart_widget.dart';
import 'widgets/not_connected_widget.dart';
import 'widgets/not_empty_cart_widget.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  void _showErrorSnackBar(BuildContext context, String message) {
    showCustomSnackBar(
      context: context,
      message: message,
      vPadding: 16,
    );
  }

  /// Handles different error states and shows appropriate error messages
  void _handleErrorState(BuildContext context, HomeStates state) {
    if (state is HomeAddUserToCartFailure) {
      _showErrorSnackBar(context, state.errMessage);
    } else if (state is HomeDeleteProductFailure) {
      _showErrorSnackBar(context, state.errMessage);
    } else if (state is HomeGetCartProductsFailure) {
      _showErrorSnackBar(context, state.errMessage);
    } else if (state is HomeGetScannedProductsFailure) {
      _showErrorSnackBar(context, state.errMessage);
    } else if (state is HomeRemoveUserFromCartFailure) {
      _showErrorSnackBar(context, state.errMessage);
    }
  }

  /// Determines the appropriate widget to display based on the current state
  Widget _buildCartContent(
      BuildContext context, HomeStates state, HomeCubit cubit) {
    if (state is HomeInitial || state is HomeRemoveUserFromCartSuccess) {
      return const NotConnectedWidget(showSnackbar: false);
    }

    if (state is HomeAddUserToCartFailure) {
      return const NotConnectedWidget(showSnackbar: false);
    }

    if (state is HomeGetCartProductsSuccess ||
        state is HomeDeleteProductSuccess ||
        state is HomeGetScannedProductsSuccess) {
      return cubit.cartProducts.isEmpty
          ? const EmptyCartWidget()
          : NotEmptyCartWidget(products: cubit.cartProducts);
    }

    return const Center(
      child: CircularProgressIndicator(color: AppColorsLight.primaryColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = HomeCubit.get(context);
    final cartId = CacheHelper.getString(key: CacheHelperKeys.cartID);

    // Fetch cart products if cart ID exists
    if (cartId != null) {
      cubit.getCartProducts(cartId);
    }

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is HomeAddUserToCartSuccess) {
          cubit.getCartProducts(cubit.cartId);
        }
        _handleErrorState(context, state);
      },
      builder: (context, state) => _buildCartContent(context, state, cubit),
    );
  }
}
