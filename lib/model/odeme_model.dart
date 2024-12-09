import 'package:hive/hive.dart';

part 'odeme_model.g.dart';

@HiveType(typeId: 3)
class OdemeGecmisiModel {
  @HiveField(0)
  String odmeID;
  @HiveField(1)
  double anaPara;
  @HiveField(2)
  double odenenPara;
  @HiveField(3)
  double kalanPara;
  @HiveField(4)
  DateTime odemeTarihi;
  OdemeGecmisiModel({
    required this.odmeID,
    required this.anaPara,
    required this.odenenPara,
    required this.kalanPara,
    required this.odemeTarihi,
  });
}
