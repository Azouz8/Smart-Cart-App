import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_cart_app/core/routing/app_router.dart';
import 'package:smart_cart_app/core/themes/light_theme/app_colors_light.dart';
import 'package:smart_cart_app/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:smart_cart_app/features/home/presentation/manager/home_cubit/home_states.dart';
import 'package:smart_cart_app/features/home/presentation/views/widgets/cart_list_view_item.dart';
import 'package:smart_cart_app/features/home/presentation/views/widgets/checkout_button.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      builder: (BuildContext context, state) {
        return SafeArea(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if (false) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    spacing: 8,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/images/qr_code.svg",
                        width: MediaQuery.sizeOf(context).width * 0.4,
                      ),
                      Text(
                        "You're not Connected to any cart, Click This Button to Scan The Cart",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontFamily: "Carmen",
                            fontWeight: FontWeight.w600,
                            color: AppColorsLight.secondaryColor),
                        textAlign: TextAlign.center,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          GoRouter.of(context).push(AppRouter.scanQRCodeView);
                        },
                        style: ButtonStyle(
                          overlayColor: WidgetStatePropertyAll(
                            Colors.black.withAlpha(15),
                          ),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          backgroundColor: WidgetStateProperty.all(
                            const Color(0xff5b9ee1),
                          ),
                        ),
                        child: Text(
                          "Scan QR Code",
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                  fontFamily: "Carmen", color: Colors.white),
                        ),
                      ),
                      Text("Your QR is : ${HomeCubit.get(context).qrCode}"),
                    ],
                  ),
                );
              } else if (false) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Column(
                    spacing: 8,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Your Cart",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(fontFamily: "Carmen"),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          const Divider(
                            thickness: 0.5,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      SvgPicture.asset(
                        "assets/images/empty_cart.svg",
                        width: MediaQuery.sizeOf(context).width * 0.4,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Your cart is empty, Hurry up and get some good products",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                fontFamily: "Carmen",
                                color: AppColorsLight.secondaryColor),
                        textAlign: TextAlign.center,
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                    ],
                  ),
                );
              } else {
                return GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Your Cart",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(fontFamily: "Carmen"),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          const Divider(
                            thickness: 0.5,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          ListView.builder(
                              itemBuilder: (context, index) =>
                                  const CartListViewItem(),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 10),
                          const CheckoutButton(),
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}
