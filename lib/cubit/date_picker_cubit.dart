import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class CubitDatePicker extends Cubit<DateTime> {
  CubitDatePicker() : super(DateTime.now());

  Future<void> pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: state, // Mevcut tarih
      firstDate: DateTime(2000), // Başlangıç tarihi
      lastDate: DateTime(2100), // Bitiş tarihi
    );

    if (pickedDate != null) {
      emit(pickedDate); // Yeni tarihi yayınla
    }
  }
}
