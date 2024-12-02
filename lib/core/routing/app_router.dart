import 'package:go_router/go_router.dart';
import 'package:smart_cart_app/features/authentication/representation/views/login_view.dart';
import 'package:smart_cart_app/features/authentication/representation/views/password_recovery.dart';
import 'package:smart_cart_app/features/authentication/representation/views/register_view.dart';

abstract class AppRouter {
  // static const homeView = "/homeView";
  // static const loginView = "/loginView";
  static const registerView = "/registerView";
  static const passwordRecoveryViewView = "/passwordRecoveryView";

  static final router = GoRouter(routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => LoginView(),
    ),
    GoRoute(
      path: registerView,
      builder: (context, state) => RegisterView(),
    ),
    GoRoute(path: passwordRecoveryViewView, builder: (context, state) => PasswordRecoveryView())
  ]);
}
