import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cart_app/core/themes/light_theme/app_colors_light.dart';
import 'package:smart_cart_app/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:smart_cart_app/features/home/presentation/manager/home_cubit/home_states.dart';
import 'ordre_info_item.dart';
import 'payment_methods_bottom_sheet.dart';
import 'total_price_widget.dart';

class CheckoutCartViewBody extends StatelessWidget {
  const CheckoutCartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is HomeGetScannedProductsSuccess) {}
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        cubit.getTotalPrice();
        cubit.getTotalDiscount();
        final String orderSubtotal = cubit.orderSubtotal;
        final String totalDiscount = cubit.totalDiscount;
        final String totalPrice = cubit.totalPrice;
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
              OrderInfoItem(
                  title: "Order Subtotal", value: "\$ $orderSubtotal"),
              OrderInfoItem(title: "Discount", value: "\$ $totalDiscount"),
              const Divider(thickness: 0.5, color: Colors.grey),
              TotalPriceWidget(price: "\$ $totalPrice"),
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
      },
    );
  }
}
