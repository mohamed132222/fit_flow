import 'package:go_router/go_router.dart';

import '../../feature/onboarding/ui/onboarding_screen.dart';
import '../../feature/splash/ui/splash_screen.dart';
import 'app_router_name.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AppRouterName.splashPath,
    routes: [
      GoRoute(
        path: AppRouterName.splashPath,
        name: AppRouterName.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRouterName.onboardingPath,
        name: AppRouterName.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
    ],
  );
}
