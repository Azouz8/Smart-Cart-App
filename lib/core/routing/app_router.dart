import 'package:go_router/go_router.dart';
import 'package:smart_cart_app/features/authentication/representation/views/login_view.dart';
import 'package:smart_cart_app/features/authentication/representation/views/password_recovery.dart';
import 'package:smart_cart_app/features/authentication/representation/views/register_view.dart';
import 'package:smart_cart_app/features/home/presentation/views/home_view.dart';
import 'package:smart_cart_app/features/home/presentation/views/scan_qr_view.dart';

abstract class AppRouter {
  static const homeView = "/homeView";
  static const loginView = "/loginView";
  static const registerView = "/registerView";
  static const passwordRecoveryView = "/passwordRecoveryView";
  static const scanQRCodeView = "/scanQRCodeView";

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
      path: homeView,
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: registerView,
      builder: (context, state) => RegisterView(),
    ),
    GoRoute(
        path: passwordRecoveryView,
        builder: (context, state) => PasswordRecoveryView()),
    GoRoute(
        path: scanQRCodeView, builder: (context, state) => const ScanQrView()),
  ]);
}
