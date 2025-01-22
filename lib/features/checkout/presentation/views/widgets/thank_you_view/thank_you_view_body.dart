import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_cart_app/core/themes/light_theme/app_colors_light.dart';

class ThankYouViewBody extends StatelessWidget {
  const ThankYouViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24, left: 24, right: 24, top: 72),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: ShapeDecoration(
              color: const Color(0xffd9d9d9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.sizeOf(context).height * 0.18 + 20,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: List.generate(
                  30,
                  (index) => Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      height: 2,
                      color: const Color(0xffb8b8b8),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.sizeOf(context).height * 0.18,
            left: -20,
            child: const CircleAvatar(
              backgroundColor: AppColorsLight.scaffoldBackgroundColor,
            ),
          ),
          Positioned(
            bottom: MediaQuery.sizeOf(context).height * 0.18,
            right: -20,
            child: const CircleAvatar(
              backgroundColor: AppColorsLight.scaffoldBackgroundColor,
            ),
          ),
          const Positioned(
            left: 0,
            right: 0,
            top: -35,
            child: CircleAvatar(
              radius: 35,
              backgroundColor: Color(0xffd9d9d9),
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.green,
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
