import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel {
  @HiveField(0)
  String userID;
  @HiveField(1)
  String userName;

  @HiveField(2)
  String userPhone;
  UserModel({
    required this.userID,
    required this.userName,
    required this.userPhone,
  });
}
