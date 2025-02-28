import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_cart_app/core/networking/api/api_consts.dart';
import 'package:smart_cart_app/core/routing/app_router.dart';
import 'package:smart_cart_app/core/services/cache_helper.dart';
import 'package:smart_cart_app/core/services/helper_functions.dart';
import 'package:smart_cart_app/features/checkout/data/models/payment_intent_input_model/payment_intent_input_model.dart';
import 'package:smart_cart_app/features/checkout/presentation/manager/checkout_cubit.dart';
import 'package:smart_cart_app/features/checkout/presentation/manager/checkout_states.dart';
import 'package:smart_cart_app/features/home/presentation/manager/home_cubit/home_cubit.dart';

class CustomConsumerButton extends StatelessWidget {
  const CustomConsumerButton({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckoutCubit, CheckoutStates>(
        listener: (context, state) {
      if (state is CheckoutSuccess) {
        var userID = CacheHelper.getString(key: CacheHelperKeys.userID);
        var cartID = CacheHelper.getString(key: CacheHelperKeys.cartID);
        HomeCubit.get(context).removeUserFromCart(cartID!, userID!);
        GoRouter.of(context).push(AppRouter.thankYouView);
      } else if (state is CheckoutFailure) {
        Navigator.of(context).pop();
        showCustomSnackBar(
            context: context, message: "Something went wrong", vPadding: 32);
      }
    }, builder: (context, state) {
      var totalPrice = HomeCubit.get(context).totalPrice;
      return ElevatedButton(
        onPressed: () {
          PaymentIntentInputModel paymentIntentInputModel =
              PaymentIntentInputModel(
                  amount: totalPrice,
                  currency: "USD",
                  customerId: ApiConsts.stripeCustomerID);
          CheckoutCubit.get(context)
              .makePayment(paymentIntentInputModel: paymentIntentInputModel);
        },
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          backgroundColor: WidgetStateProperty.all(const Color(0xff5b9ee1)),
        ),
        child: state is CheckoutLoading
            ? const SizedBox(
                height: 15,
                width: 15,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontFamily: "Carmen",
                    ),
              ),
      );
    });
  }
}
