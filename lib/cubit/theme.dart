import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Cubit<bool> {
  ThemeBloc() : super(true);

  void thmeConvert() {
    emit(!state);
  }
}
