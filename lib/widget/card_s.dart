import 'package:flutter/material.dart';
import 'package:hesapp/constant/colors.dart';

// ignore: must_be_immutable
class SbtCard extends StatelessWidget {
  final IconData icon;
  final String yazi;
  Function() onTap;
  double sizeWidth;
  bool color;
  SbtCard({
    super.key,
    required this.icon,
    required this.onTap,
    required this.yazi,
    required this.color,
    required this.sizeWidth,
  });

  @override
  Widget build(BuildContext context) {
    // Ekran genişliğini alıyoruz
    return InkWell(
      onTap: onTap,
      child: Card(
        // Kartın üzerine hafif bir gölge ekleyerek derinlik kazandırıyoruz
        elevation: 8,
        shape: RoundedRectangleBorder(
          // Kartın kenarlarını yuvarlatıyoruz
          borderRadius: BorderRadius.circular(32),
        ),
        color: color == true
            ? SbtAppColors.successColor
            : SbtAppColors.warningColor,
        child: sizebox(),
      ),
    );
  }

  SizedBox sizebox() {
    return SizedBox(
      width: sizeWidth / 2,
      height: sizeWidth / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Başlık kısmına daha büyük bir boşluk ekliyoruz
          SizedBox(height: sizeWidth / 12),

          // İkonu daha dikkat çekici hale getiriyoruz
          // İkon boyutunu büyütüyoruz
          Icon(
            icon,
            size: sizeWidth / 8,
            color: SbtAppColors.textColor,
          ),

          // Başlık kısmını daha şık hale getiriyoruz
          SizedBox(height: sizeWidth / 12),
          Text(
            yazi,
            style: style(),
          ),
        ],
      ),
    );
  }

  TextStyle style() {
    return TextStyle(
      color: SbtAppColors.textColor,
      // Yazı boyutunu artırıyoruz
      fontSize: sizeWidth / 20,
      fontWeight: FontWeight.bold,
      // Harfler arasında biraz boşluk bırakarak modern bir hava katıyoruz
      letterSpacing: 1.5,
      shadows: [
        Shadow(
          offset: const Offset(2, 2),
          blurRadius: 5,
          color: Colors.black.withOpacity(0.3),
        ),
      ],
    );
  }
}
