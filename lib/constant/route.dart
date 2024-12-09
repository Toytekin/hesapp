// Rota Sabitleri
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hesapp/page/BORC/borc_detay/borc_detay.dart';
import 'package:hesapp/page/BORC/borc_home/home_borc.dart';
import 'package:hesapp/page/BORC/borcekleme/borc_ekleme.dart';
import 'package:hesapp/page/home/home.dart';
import 'package:hesapp/page/home/splash.dart';

class AppRoutes {
  static const String home = '/';
  static const String splash = '/splash';
  static const String homeBorc = '/homeborc';
  static const String userAdd = '/useradd';
  static const String borcAdd = '/borcadd';
  static const String borcDetat = '/borcdetay';
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
    GoRoute(
      path: AppRoutes.homeBorc,
      pageBuilder: (context, state) {
        return animasyonluGecis(const HomeBorc());
      },
      builder: (context, state) => const HomeBorc(),
    ),
    GoRoute(
      path: AppRoutes.borcAdd,
      pageBuilder: (context, state) {
        return animasyonluGecis(const BorcEklemeScreen());
      },
      builder: (context, state) => const BorcEklemeScreen(),
    ),
    GoRoute(
      path: AppRoutes.borcDetat,
      pageBuilder: (context, state) {
        return animasyonluGecis(const BorcDetayScreen());
      },
      builder: (context, state) => const BorcDetayScreen(),
    )
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
