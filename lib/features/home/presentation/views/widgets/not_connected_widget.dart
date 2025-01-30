import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_cart_app/core/routing/app_router.dart';
import 'package:smart_cart_app/core/themes/light_theme/app_colors_light.dart';

class NotConnectedWidget extends StatelessWidget {
  const NotConnectedWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                  .copyWith(fontFamily: "Carmen", color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
