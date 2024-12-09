import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hesapp/cubit/user_add_cubit.dart';
import 'package:hesapp/model/user_model.dart';
import 'package:hesapp/page/BORC/borcekleme/borc_ekleme.dart';

mixin ViewBorcEkleme on State<BorcEklemeScreen> {
//! DEĞİŞKENLER

  TextEditingController namController = TextEditingController();
  TextEditingController fiyatController = TextEditingController();
  //User controller
  TextEditingController userNamController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();

  DateTime todaTime = DateTime.now();

  UserModel? borcluUser;
//!  İNİT STATE
  @override
  void initState() {
    super.initState();
    context.read<UserAddCubit>().getAllUsers();
  }
//! FONKSİYONLAR
}
