import 'package:flutter/material.dart';
import 'package:smart_cart_app/core/themes/light_theme/app_colors_light.dart';
import 'ordre_info_item.dart';
import 'payment_methods_bottom_sheet.dart';
import 'total_price_widget.dart';

class CheckoutCartViewBody extends StatelessWidget {
  const CheckoutCartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 15,
        children: [
          Expanded(
            child: Image.asset(
              "assets/images/cart_products.png",
            ),
          ),
          const OrderInfoItem(title: "Order Subtotal", value: "\$1200.45"),
          const OrderInfoItem(title: "Discount", value: "\$50"),
          const Divider(thickness: 0.5, color: Colors.grey),
          const TotalPriceWidget(price: "\$1950.45"),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // GoRouter.of(context).push(AppRouter.paymentDetailsView);
                showModalBottomSheet(
                  backgroundColor: AppColorsLight.scaffoldBackgroundColor,
                  context: context,
                  builder: (context) {
                    return const PaymentMethodsBottomSheet();
                  },
                );
              },
              style: ButtonStyle(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                backgroundColor:
                    WidgetStateProperty.all(const Color(0xff5b9ee1)),
              ),
              child: Text(
                "Complete Payment",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontFamily: "Carmen",
                    ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}