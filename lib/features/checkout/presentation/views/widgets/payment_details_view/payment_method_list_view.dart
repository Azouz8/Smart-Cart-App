import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'payment_method_item.dart';

class PaymentMethodListView extends StatefulWidget {
  const PaymentMethodListView({super.key});

  @override
  State<PaymentMethodListView> createState() => _PaymentMethodListViewState();
}

class _PaymentMethodListViewState extends State<PaymentMethodListView> {
  int activeIndex = 0;
  final List<String> paymentMethods = [
    "assets/images/credit_card.svg",
    "assets/images/paypal.svg",
    "assets/images/cash.svg",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 62.h,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          spacing: 8,
          children: List.generate(
            paymentMethods.length,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  activeIndex = index;
                });
              },
              child: PaymentMethodItem(
                isActive: activeIndex == index,
                image: paymentMethods[index],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
