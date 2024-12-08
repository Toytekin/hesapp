import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hesapp/model/user_model.dart';
import 'package:hive/hive.dart';

class UserAddCubit extends Cubit<List<UserModel>> {
  UserAddCubit() : super([]);

  var userBox = Hive.box<UserModel>('userBox');

  // List of users is not needed, you can directly emit the new state
  Future<void> userAdd(UserModel userModel) async {
    await userBox.put(userModel.userID, userModel);
    // Emit the updated list directly after adding a new user
    emit(userBox.values.toList());
  }

  Future<void> userDelete(UserModel userModel) async {
    await userBox.delete(userModel.userID);
    // Emit the updated list after deleting a user
    emit(userBox.values.toList());
  }

  // This function can be used to fetch all users once at the start or when needed
  void getAllUsers() {
    // Directly emit the list of users from the box
    emit(userBox.values.toList());
  }
}
