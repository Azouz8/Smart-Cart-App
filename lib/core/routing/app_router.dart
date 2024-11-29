import 'package:go_router/go_router.dart';

import '../../features/authentication/representation/views/login_view.dart';

abstract class AppRouter {
  // static const homeView = "/homeView";
  // static const loginView = "/loginView";
  // static const registerView = "/registerView";

  static final router = GoRouter(routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const LoginView(),
    )
  ]);
}
