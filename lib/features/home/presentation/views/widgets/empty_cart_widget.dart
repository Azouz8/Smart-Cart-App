import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_cart_app/core/themes/light_theme/app_colors_light.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontFamily: "Carmen", color: AppColorsLight.secondaryColor),
            textAlign: TextAlign.center,
          ),
          const Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }
}
