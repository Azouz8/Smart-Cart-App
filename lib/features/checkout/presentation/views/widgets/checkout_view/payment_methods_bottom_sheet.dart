import 'package:flutter/material.dart';
import 'package:smart_cart_app/core/routing/app_router.dart';
import '../payment_details_view/payment_method_list_view.dart';
import '../thank_you_view/thank_you_view_body.dart';

class PaymentMethodsBottomSheet extends StatelessWidget {
  const PaymentMethodsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        spacing: 16,
        mainAxisSize: MainAxisSize.min,
        children: [
          PaymentMethodListView(),
          SizedBox(
            width: double.infinity,
            child:
                CustomButton(title: "Continue", route: AppRouter.thankYouView),
          ),
        ],
      ),
    );
  }
}
