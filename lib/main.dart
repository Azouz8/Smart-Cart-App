import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cart_app/core/themes/light_theme/light_theme.dart';
import 'core/routing/app_router.dart';

void main() => runApp(
      DevicePreview(
        enabled: true,
        builder: (context) => const SmartCart(), // Wrap your app
      ),
    );

class SmartCart extends StatelessWidget {
  const SmartCart({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(380, 700),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          useInheritedMediaQuery: true,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          routerConfig: AppRouter.router,
          debugShowCheckedModeBanner: false,
          theme: getLightTheme(),
        );
      },
    );
  }
}
