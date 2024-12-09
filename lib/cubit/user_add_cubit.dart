import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hesapp/model/user_model.dart';
import 'package:hive/hive.dart';

class UserAddCubit extends Cubit<List<UserModel>> {
  UserAddCubit() : super([]);

  var userBox = Hive.box<UserModel>('userBox');

  Future<void> userAdd(UserModel userModel) async {
    await userBox.put(userModel.userID, userModel);
    emit(userBox.values.toList());
  }

  Future<void> userDelete(UserModel userModel) async {
    await userBox.delete(userModel.userID);
    emit(userBox.values.toList());
  }

  void getAllUsers() {
    emit(userBox.values.toList());
  }

  void filterUsers(String query) {
    if (query.isEmpty) {
      getAllUsers();
    } else {
      var filteredUsers = userBox.values
          .where((user) =>
              user.userName.toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(filteredUsers);
    }
  }
}
