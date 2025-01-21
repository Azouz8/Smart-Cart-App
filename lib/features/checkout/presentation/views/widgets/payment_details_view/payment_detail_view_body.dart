import 'package:flutter/material.dart';
import 'package:smart_cart_app/features/checkout/presentation/views/widgets/payment_details_view/payment_method_list_view.dart';

class PaymentDetailViewBody extends StatelessWidget {
  const PaymentDetailViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PaymentMethodListView(),
        ],
      ),
    );
  }
}
