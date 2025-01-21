import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cart_app/features/checkout/presentation/views/widgets/payment_details_view/payment_method_item.dart';

class PaymentMethodListView extends StatefulWidget {
  const PaymentMethodListView({super.key});

  @override
  State<PaymentMethodListView> createState() => _PaymentMethodListViewState();
}

class _PaymentMethodListViewState extends State<PaymentMethodListView> {
  int activeIndex = 0;
  final List<String> paymentMethods = [
    "assets/images/credit_card.svg",
    "assets/images/paypal.svg"
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 62.h,
      width: MediaQuery.of(context).size.width,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: paymentMethods.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            activeIndex = index;
            setState(() {});
          },
          child: PaymentMethodItem(
              isActive: activeIndex == index, image: paymentMethods[index]),
        ),
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 16.w,
          );
        },
      ),
    );
  }
}
