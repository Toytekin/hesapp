import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hesapp/model/user_model.dart';

class SecilenUserCubit extends Cubit<UserModel?> {
  SecilenUserCubit() : super(null);

  void secilenUser(UserModel userModel) {
    emit(userModel);
  }
}
