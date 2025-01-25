import 'package:flutter/material.dart';
import 'package:smart_cart_app/features/checkout/presentation/views/widgets/payment_details_view/payment_detail_view_body.dart';

class PaymentDetailsView extends StatelessWidget {
  const PaymentDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Payment Details",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: true,
      ),
      body:  const PaymentDetailViewBody(),
    );
  }
}
