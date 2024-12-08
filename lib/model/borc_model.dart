// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hesapp/model/user_model.dart';

import 'package:hive/hive.dart';

part 'borc_model.g.dart';

@HiveType(typeId: 2)
class BorcModel {
  @HiveField(0)
  UserModel userModel;
  @HiveField(1)
  String borcID;
  @HiveField(2)
  String borcName;
  @HiveField(3)
  double borc;
  @HiveField(4)
  DateTime borcAlinanTarih;
  @HiveField(5)
  DateTime? odemeTarihi;
  @HiveField(6)
  DateTime? odenecekSonTarih;
  @HiveField(7)
  bool borcOdemeDurumu;

  BorcModel({
    required this.borcID,
    required this.userModel,
    required this.borcName,
    required this.borc,
    required this.borcAlinanTarih,
    required this.odenecekSonTarih,
    this.odemeTarihi,
    this.borcOdemeDurumu = false,
  });
}
