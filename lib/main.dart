import 'package:flutter/material.dart';
import 'package:smart_cart_app/core/themes/light_theme/light_theme.dart';
import 'core/routing/app_router.dart';

void main() {
  runApp(const SmartCart());
}

class SmartCart extends StatelessWidget {
  const SmartCart({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
      theme: getLightTheme(),
    );
  }
}
