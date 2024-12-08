import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hesapp/model/borc_model.dart';
import 'package:hesapp/model/user_model.dart';
import 'package:hive/hive.dart';

class BorcCubit extends Cubit<List<BorcModel>> {
  BorcCubit() : super([]);

  var borcBox = Hive.box<BorcModel>('borcBox');
  List<BorcModel> filterList = [];

  // List of users is not needed, you can directly emit the new state
  Future<void> borcAdd(BorcModel borcmodel) async {
    await borcBox.put(borcmodel.borcID, borcmodel);
    // Emit the updated list directly after adding a new user
    emit(borcBox.values.toList());
  }

  Future<void> borcDelete(BorcModel borcmodel) async {
    await borcBox.delete(borcmodel.borcID);
    // Emit the updated list after deleting a user
    emit(borcBox.values.toList());
  }

  // This function can be used to fetch all users once at the start or when needed
  void getFilterUsers(UserModel userModel) {
    for (var element in borcBox.values) {
      if (element.userModel.userID == userModel.userID) {
        filterList.add(element);
      }
    }
    emit(filterList);
  }
}
