import 'package:go_router/go_router.dart';
import 'package:stellar_demo/Presentation/Main/main_handler.dart';
import 'package:stellar_demo/Presentation/authentication_screen.dart';

class Routes {
  static const authenticate = '/auth';
  static const signIn = '/sign-in';
  static const main = '/profile';
}

final GoRouter router = GoRouter(
  initialLocation: Routes.authenticate,
  routes: [
    // GoRoute(
    //   path: Routes.authenticate,
    //   builder: (context, state) => AuthenticationScreen(),
    // ),
    // GoRoute(
    //   path: Routes.main,
    //   builder: (context, state) => MainHandler(),
    // ),
  ],
);
