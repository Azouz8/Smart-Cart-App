import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_cart_app/core/services/service_locator.dart';
import 'package:smart_cart_app/features/authentication/presentation/views/login_view.dart';
import 'package:smart_cart_app/features/authentication/presentation/views/password_recovery.dart';
import 'package:smart_cart_app/features/authentication/presentation/views/register_view.dart';
import 'package:smart_cart_app/features/authentication/presentation/views/verification_view.dart';
import 'package:smart_cart_app/features/category_selection/data/repos/category_repo_impl.dart';
import 'package:smart_cart_app/features/category_selection/presentation/manager/category_cubit.dart';
import 'package:smart_cart_app/features/category_selection/presentation/views/categories_view.dart';
import 'package:smart_cart_app/features/checkout/presentation/views/checkout_cart_view.dart';
import 'package:smart_cart_app/features/checkout/presentation/views/payment_details_view.dart';
import 'package:smart_cart_app/features/checkout/presentation/views/thank_you_view.dart';
import 'package:smart_cart_app/features/home/presentation/views/home_view.dart';
import 'package:smart_cart_app/features/home/presentation/views/scan_qr_view.dart';
import 'package:smart_cart_app/features/rating/presentation/views/rate_products_view.dart';

abstract class AppRouter {
  static const homeView = "/homeView";
  static const loginView = "/loginView";
  static const registerView = "/registerView";
  static const verificationView = "/verificationView";
  static const passwordRecoveryView = "/passwordRecoveryView";
  static const scanQRCodeView = "/scanQRCodeView";
  static const checkoutCartView = "/checkoutCartView";
  static const paymentDetailsView = "/paymentDetailsView";
  static const thankYouView = "/thankYouView";
  static const rateProductsView = "/rateProductsView";
  static const categoriesView = "/categoriesView";

  static final router = GoRouter(routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => LoginView(),
    ),
    GoRoute(
      path: loginView,
      builder: (context, state) => LoginView(),
    ),
    GoRoute(
      path: registerView,
      builder: (context, state) => const RegisterView(),
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const RegisterView(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: homeView,
      builder: (context, state) => const HomeView(),
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const HomeView(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0);
          const end = Offset.zero;
          const curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: verificationView,
      builder: (context, state) => const VerificationView(),
    ),
    GoRoute(
      path: passwordRecoveryView,
      builder: (context, state) => PasswordRecoveryView(),
      pageBuilder: (context, state) => CustomTransitionPage(
        child: PasswordRecoveryView(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: scanQRCodeView,
      pageBuilder: (context, state) => CustomTransitionPage(
        child: BlocProvider(
          create: (context) => CategoryCubit(getIt.get<CategoryRepoImpl>()),
          child: ScanQrView(),
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          );
          final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          );
          return ScaleTransition(
            scale: scaleAnimation,
            child: FadeTransition(opacity: fadeAnimation, child: child),
          );
        },
      ),
    ),
    GoRoute(
      path: checkoutCartView,
      builder: (context, state) => const CheckoutCartView(),
    ),
    GoRoute(
      path: paymentDetailsView,
      builder: (context, state) => const PaymentDetailsView(),
    ),
    GoRoute(
      path: thankYouView,
      builder: (context, state) => const ThankYouView(),
    ),
    GoRoute(
      path: rateProductsView,
      builder: (context, state) => const RateProductsView(),
    ),
    GoRoute(
      path: categoriesView,
      pageBuilder: (context, state) => CustomTransitionPage(
        child: BlocProvider(
          create: (context) => CategoryCubit(getIt.get<CategoryRepoImpl>()),
          child: const CategoriesView(),
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          );
          final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          );
          return ScaleTransition(
            scale: scaleAnimation,
            child: FadeTransition(opacity: fadeAnimation, child: child),
          );
        },
      ),
    ),
  ]);
}
