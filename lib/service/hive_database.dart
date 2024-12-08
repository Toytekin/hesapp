import 'package:hesapp/model/borc_model.dart';
import 'package:hesapp/model/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveSetup {
  /// Hive'i başlat ve adapter'leri kaydet
  static Future<void> initialize() async {
    await Hive.initFlutter();

    // Adapter kayıt işlemleri
    Hive.registerAdapter<UserModel>(UserModelAdapter());
    Hive.registerAdapter<BorcModel>(BorcModelAdapter());

    // Box'lar açılabilir (isteğe bağlı)
    await Hive.openBox<UserModel>('userBox');
    await Hive.openBox<BorcModel>('borcBox');
  }
}
