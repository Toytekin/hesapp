import 'package:flutter/material.dart';
import 'package:hesapp/constant/colors.dart';

class AppTheme {
  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: SbtAppColors.primaryColor,
    scaffoldBackgroundColor: SbtAppColors.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: SbtAppColors.primaryColor,
      foregroundColor: SbtAppColors.cardColor,
      elevation: 4, // App bar için gölge ekleyerek derinlik sağlıyoruz
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: SbtAppColors.cardColor,
      ),
    ),
    cardColor: SbtAppColors.cardColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: SbtAppColors.primaryColor, // Buton arka plan rengi
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Butonları yuvarlak yapmak
        ),
        padding: const EdgeInsets.symmetric(
            vertical: 12, horizontal: 24), // Butonun iç boşlukları
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: const TextStyle(
        color: SbtAppColors.textColor,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: TextStyle(
        color:
            SbtAppColors.textColor.withOpacity(0.7), // Daha soft bir yazı rengi
        fontSize: 14,
      ),
      bodySmall: TextStyle(
        color: SbtAppColors.textColor.withOpacity(0.6), // Daha ince yazı
        fontSize: 12,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: SbtAppColors.secondaryColor,
      foregroundColor: Colors.white,
      elevation: 6, // Yüzer efekt ekledik
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: SbtAppColors.backgroundColor,
      selectedItemColor: SbtAppColors.primaryColor,
      unselectedItemColor: SbtAppColors.textColor.withOpacity(0.6),
      elevation: 8, // Navigasyon çubuğu için biraz gölge ekliyoruz
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(
            color: SbtAppColors.primaryColor
                .withOpacity(0.3)), // İnce bir kenarlık
        borderRadius: BorderRadius.circular(8), // Yuvarlatılmış kenarlıklar
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
            color: SbtAppColors.primaryColor), // Odaklandığında renk değişir
        borderRadius: BorderRadius.circular(8),
      ),
      hintStyle: TextStyle(color: SbtAppColors.textColor.withOpacity(0.6)),
    ),
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: SbtAppColors.secondaryColor,
    scaffoldBackgroundColor:
        SbtAppColors.backgroundColor, // Koyu temada daha uygun bir arka plan
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 1, 27, 32),
      foregroundColor: SbtAppColors.cardColor,
      elevation: 4,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: SbtAppColors.cardColor,
      ),
    ),
    cardColor: SbtAppColors.cardColor, // Koyu temada kart renkleri
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: SbtAppColors.secondaryColor, // Buton arka plan rengi
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: const TextStyle(
        color: SbtAppColors.cardColor,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: TextStyle(
        color: SbtAppColors.cardColor.withOpacity(0.7),
        fontSize: 14,
      ),
      bodySmall: TextStyle(
        color: SbtAppColors.cardColor.withOpacity(0.6),
        fontSize: 12,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: SbtAppColors.warningColor,
      foregroundColor: Colors.black,
      elevation: 6,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: SbtAppColors.backgroundColor,
      selectedItemColor: SbtAppColors.secondaryColor,
      unselectedItemColor: SbtAppColors.cardColor.withOpacity(0.6),
      elevation: 8,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide:
            BorderSide(color: SbtAppColors.secondaryColor.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: SbtAppColors.secondaryColor),
        borderRadius: BorderRadius.circular(8),
      ),
      hintStyle: TextStyle(color: SbtAppColors.cardColor.withOpacity(0.6)),
    ),
  );
}
