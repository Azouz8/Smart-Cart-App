import 'package:flutter/material.dart';
import '../themes/light_theme/app_colors_light.dart';

void showCustomSnackBar(
    {required BuildContext context, required String message , required double vPadding}) {
  final AnimationController controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: ScaffoldMessenger.of(context), // Use ScaffoldMessenger as the vsync
  );

  final Animation<Offset> slideAnimation = Tween<Offset>(
    begin: const Offset(0, 1), // Start from the bottom
    end: Offset.zero, // End at the top
  ).animate(CurvedAnimation(
    parent: controller,
    curve: Curves.easeOut,
  ));

  final Animation<double> fadeAnimation = Tween<double>(
    begin: 0,
    end: 1,
  ).animate(CurvedAnimation(
    parent: controller,
    curve: Curves.easeIn,
  ));

  controller.forward();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      margin:  EdgeInsets.symmetric(horizontal: 24, vertical: vPadding),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return SlideTransition(
            position: slideAnimation,
            child: FadeTransition(
              opacity: fadeAnimation,
              child: Text(
                message,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Colors.white),
              ),
            ),
          );
        },
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColorsLight.primaryColor2,
      duration: const Duration(milliseconds: 1500), // Adjust duration as needed
    ),
  );

  // Dispose the controller when the SnackBar is closed
  WidgetsBinding.instance.addPostFrameCallback((_) {
    Future.delayed(const Duration(milliseconds: 1500), () {
      controller.dispose();
    });
  });
}
