import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hesapp/constant/path.dart';
import 'package:hesapp/constant/route.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  // Home ekranına yönlendiren fonksiyon
  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 1)); // 2 saniye bekleyin
    if (mounted) {
      context.go(AppRoutes.home); // Ana ekran yolu, GoRouter'da tanımlı olmalı
    }
  }

  @override
  Widget build(BuildContext context) {
    // Ekran genişliğini alıyoruz
    double sizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: 0.5,
            image: AssetImage(SbtPath.ALTIN),
            fit: BoxFit
                .cover, // Görseli tam olarak sayfayı kaplayacak şekilde ölçekler
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'HesApp',
                style: TextStyle(
                  fontSize: sizeWidth * 0.13,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
