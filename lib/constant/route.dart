// Rota Sabitleri
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hesapp/page/home/home.dart';
import 'package:hesapp/page/home/splash.dart';

class AppRoutes {
  static const String home = '/';
  static const String splash = '/splash';
  static const String settings = '/settings';
  static const String profile = '/profile';
  static const String about = '/about';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash, // Splash ekranı ile başlat
  routes: [
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomeScreen(),
      pageBuilder: (context, state) {
        return animasyonluGecis(const HomeScreen());
      },
    ),
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    // GoRoute(
    //   path: AppRoutes.profile,
    //   builder: (context, state) => const ProfileScreen(),
    // ),
    // GoRoute(
    //   path: AppRoutes.about,
    //   builder: (context, state) => const AboutScreen(),
    // ),
  ],
);

// ignore: non_constant_identifier_names
CustomTransitionPage<dynamic> animasyonluGecis(Widget Screen) {
  return CustomTransitionPage(
    transitionDuration: const Duration(milliseconds: 500), // Geçiş süresi
    child: Screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Fade animasyonu
      var opacity = Tween(begin: 0.0, end: 1.0).animate(animation);
      return FadeTransition(opacity: opacity, child: child);
    },
  );
}
