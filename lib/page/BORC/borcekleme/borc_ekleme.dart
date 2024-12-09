// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hesapp/constant/colors.dart';
import 'package:hesapp/constant/path.dart';
import 'package:hesapp/constant/route.dart';
import 'package:hesapp/cubit/borc_cubit.dart';
import 'package:hesapp/cubit/date_picker_cubit.dart';
import 'package:hesapp/cubit/user_add_cubit.dart';
import 'package:hesapp/model/borc_model.dart';
import 'package:hesapp/model/user_model.dart';
import 'package:hesapp/page/BORC/borcekleme/view_borcekleme.dart';
import 'package:hesapp/widget/textfild.dart';
import 'package:lottie/lottie.dart';
import 'package:uuid/uuid.dart';

class BorcEklemeScreen extends StatefulWidget {
  const BorcEklemeScreen({super.key});

  @override
  State<BorcEklemeScreen> createState() => _BorcEklemeScreenState();
}

class _BorcEklemeScreenState extends State<BorcEklemeScreen>
    with ViewBorcEkleme, TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              context.go(AppRoutes.homeBorc);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          automaticallyImplyLeading: false,
          title: const Text('Yeni Borç Ekleme Sayfası'),
        ),
        body: Stack(
          children: [
            // Lottie Animasyonu Arkaplan
            Positioned.fill(
              child: Opacity(
                opacity: 0.1,
                child: Lottie.asset(
                  SbtPath.MONEY,
                  fit: BoxFit.cover, // Animasyonu kapsayacak şekilde ayarla
                  repeat: true,
                ),
              ),
            ),
            // Diğer Widget'lar
            Center(
              child: Padding(
                padding: const EdgeInsets.all(28.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SbtTextField(
                      controller: namController,
                      icon: const Icon(Icons.title),
                      label: 'Başlık',
                    ),
                    const SizedBox(height: 20),
                    SbtTextField(
                      keybordNumbber: true,
                      controller: fiyatController,
                      icon: const Icon(Icons.attach_money),
                      label: 'Borç',
                    ),
                    tarihSecmeYeri(),
                    Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Kime Borçlusun:'),
                          BlocBuilder<UserAddCubit, List<UserModel>>(
                            builder: (context, state) {
                              if (state.isNotEmpty) {
                                return DropdownButton<UserModel>(
                                  value: borcluUser,
                                  hint: const Text('Kullanıcı Seçin'),
                                  items: state.map((user) {
                                    return DropdownMenuItem<UserModel>(
                                      value: user,
                                      child: Text(user.userName),
                                    );
                                  }).toList(),
                                  onChanged: (UserModel? selectedUser) {
                                    if (selectedUser != null) {
                                      borcluUser = selectedUser;
                                      setState(() {});
                                    }
                                  },
                                );
                              } else {
                                return const Text('Hiç Kullanıcı Eklenmemiş');
                              }
                            },
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        var odenecekSonTarih =
                            context.read<CubitDatePicker>().state;
                        String borcID = const Uuid().v1();
                        if (namController.text.isNotEmpty &&
                            fiyatController.text.isNotEmpty &&
                            borcluUser != null) {
                          var borcItem = BorcModel(
                            borcID: borcID,
                            userModel: borcluUser!,
                            borcName: namController.text,
                            borc: double.parse(fiyatController.text),
                            guncelBorc: double.parse(fiyatController.text),
                            borcAlinanTarih: todaTime,
                            odenecekSonTarih: odenecekSonTarih,
                          );
                          context.read<BorcCubit>().borcAdd(borcItem);
                          namController.clear();
                          fiyatController.clear();
                          context.go(AppRoutes.homeBorc);
                        } else {
                          final snackBar = SnackBar(
                            content: const Text(
                                'Tüm alanların dolu ve bir kişi seçtiğine emin olduktan sonra tekrar dene'),
                            action: SnackBarAction(
                              label: 'Geri Al',
                              onPressed: () {},
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      label: const Text(
                        'Kaydet',
                        style: TextStyle(color: Colors.white),
                      ),
                      icon: const Icon(
                        Icons.save,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: ElevatedButton(
          onPressed: () => _personAddDiyalog(context),
          child: const Text(
            'Kişi Ekle',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  BlocBuilder<CubitDatePicker, DateTime> tarihSecmeYeri() {
    return BlocBuilder<CubitDatePicker, DateTime>(
      builder: (context, state) {
        return Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                ' Ödeme Son Tarih: ${formatDatetime(state)}',
                style: const TextStyle(
                  color: SbtAppColors.errorColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                  onPressed: () =>
                      context.read<CubitDatePicker>().pickDate(context),
                  icon: const Icon(Icons.date_range))
            ],
          ),
        );
      },
    );
  }

  String formatDatetime(DateTime datetime) {
    return "${datetime.day}/${datetime.month}/${datetime.year} ";
  }

  void _personAddDiyalog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Yeni Kişi Ekle'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SbtTextField(
                  controller: userNamController,
                  icon: const Icon(Icons.person),
                  label: 'Ad Soyad'),
              SbtTextField(
                  keybordNumbber: true,
                  controller: userPhoneController,
                  icon: const Icon(Icons.phone),
                  label: 'Telefon')
            ],
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  userNamController.clear();
                  userPhoneController.clear();
                  Navigator.pop(context);
                },
                child: const Text(
                  'Vazgeç',
                  style: TextStyle(color: Colors.white),
                )),
            ElevatedButton(
                onPressed: () => _userAdd(context),
                child: const Text(
                  'Kaydet',
                  style: TextStyle(color: Colors.white),
                )),
          ],
        );
      },
    );
  }

  void _userAdd(params) {
    if (userNamController.text.isNotEmpty &&
        userPhoneController.text.isNotEmpty) {
      String userID = const Uuid().v1();
      UserModel user = UserModel(
          userID: userID,
          userName: userNamController.text,
          userPhone: userPhoneController.text);

      context.read<UserAddCubit>().userAdd(user);
      Navigator.pop(context);
    } else {
      // Snackbar gösterimi
      const snackBar = SnackBar(
        content: Text('Tüm alanların dolu olduğuna emin ol'),
      );
      // ScaffoldMessenger kullanarak Snackbar'ı göster
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
