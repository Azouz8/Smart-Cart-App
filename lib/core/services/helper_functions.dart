import 'package:flutter/material.dart';

import '../themes/light_theme/app_colors_light.dart';

showCustomSnackBar({required BuildContext context, required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      margin: const EdgeInsets.all(8),
      content: Text(
        message,
        style: Theme.of(context)
            .textTheme
            .labelMedium!
            .copyWith(color: Colors.white),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColorsLight.primaryColor,
    ),
  );
}
