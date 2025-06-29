import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_cart_app/core/routing/app_router.dart';
import 'package:smart_cart_app/core/services/cache_helper.dart';
import 'package:smart_cart_app/core/themes/light_theme/app_colors_light.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (CacheHelper.getBoolean(key: CacheHelperKeys.onBoarding) == null ||
            CacheHelper.getBoolean(key: CacheHelperKeys.onBoarding) == false) {
          GoRouter.of(context).go(AppRouter.onBoardingView);
        } else {
          GoRouter.of(context).go(AppRouter.loginView);
        }
      },
    );
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLightMode = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      body: Container(
        width: double.infinity,
        color:
            isLightMode ? AppColorsLight.primaryColor : const Color(0xff222732),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset("assets/images/splash_icon.png"),
            const Spacer(),
            Text(
              "SSC",
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  fontSize: 30,
                  // fontStyle: FontStyle.italic,
                  fontFamily: "Boldonse",
                  letterSpacing: 2),
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.04),
          ],
        ),
      ),
    );
  }
}
