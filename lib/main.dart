import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:smart_cart_app/core/networking/api/api_consts.dart';
import 'package:smart_cart_app/core/services/cache_helper.dart';
import 'package:smart_cart_app/core/services/service_locator.dart';
import 'package:smart_cart_app/core/themes/light_theme/light_theme.dart';
import 'package:smart_cart_app/features/checkout/data/repos/checkout_repo_impl.dart';
import 'package:smart_cart_app/features/checkout/presentation/manager/checkout_cubit.dart';
import 'package:smart_cart_app/features/home/data/repos/home_repo_impl.dart';
import 'package:smart_cart_app/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:smart_cart_app/features/home/presentation/manager/layout_cubit/layout_cubit.dart';

import 'core/routing/app_router.dart';
import 'core/services/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = ApiConsts.stripePK;
  setupServiceLocator();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const SmartCart(),
    ),
  );
}

class SmartCart extends StatelessWidget {
  const SmartCart({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LayoutCubit()),
        BlocProvider(create: (context) => HomeCubit(getIt.get<HomeRepoImpl>())),
        BlocProvider(
            create: (context) => CheckoutCubit(getIt.get<CheckoutRepoImpl>())),
      ],
      child: ScreenUtilInit(
        designSize: const Size(380, 700),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            routerConfig: AppRouter.router,
            debugShowCheckedModeBanner: false,
            theme: getLightTheme(),
          );
        },
      ),
    );
  }
}
