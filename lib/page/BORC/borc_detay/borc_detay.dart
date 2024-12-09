// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hesapp/constant/route.dart';
import 'package:hesapp/cubit/borc_cubit.dart';
import 'package:hesapp/cubit/user_add_cubit.dart';
import 'package:hesapp/model/borc_model.dart';
import 'package:hesapp/page/BORC/borc_detay/card_widget.dart';
import 'package:hesapp/page/BORC/borc_detay/secilen_user_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class BorcDetayScreen extends StatefulWidget {
  const BorcDetayScreen({super.key});

  @override
  State<BorcDetayScreen> createState() => _BorcDetayScreenState();
}

class _BorcDetayScreenState extends State<BorcDetayScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      borclariGetir();
    });
  }

  void borclariGetir() {
    final secilenUserState = context.read<SecilenUserCubit>().state;

    if (secilenUserState != null) {
      context.read<BorcCubit>().getFilterUsers(secilenUserState);
    } else {
      // Eğer state null ise, hata yönetimi veya kullanıcıya bir mesaj göstermek için ek işlemler yapılabilir.
      debugPrint("Seçilen kullanıcı bulunamadı.");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Ekran genişliğini alıyoruz
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => context.go(AppRoutes.homeBorc),
              icon: const Icon(Icons.arrow_back_ios_new)),
          automaticallyImplyLeading: false,
          title: Text(context.read<SecilenUserCubit>().state!.userName),
          actions: [userDeleteIcon(context)],
        ),
        body: BlocBuilder<BorcCubit, List<BorcModel>>(
          builder: (context, state) {
            if (state.isNotEmpty) {
              return ListView.builder(
                itemCount: state.length,
                itemBuilder: (context, index) {
                  var item = state[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BorcCard(item: item),
                  );
                },
              );
            } else {
              return const Center(
                child: Text('Eklenmiş borç bulunmamaktadır'),
              );
            }
          },
        ),
        floatingActionButton: telefonEtme(context),
      ),
    );
  }

  ElevatedButton telefonEtme(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        final phoneNumber =
            context.read<SecilenUserCubit>().state?.userPhone; // Null kontrolü
        if (phoneNumber != null) {
          final Uri telUri = Uri(
            scheme: 'tel',
            path: phoneNumber,
          );
          launchUrl(telUri).then((success) {
            if (success) {
              context.go(AppRoutes.homeBorc); // Ana sayfaya yönlendir
            } else {
              debugPrint('Telefon uygulaması açılamadı.');
            }
          });
        } else {
          debugPrint("Telefon numarası bulunamadı.");
        }
      },
      label: const Text(
        'Ara',
        style: TextStyle(color: Colors.white),
      ),
      icon: const Icon(
        Icons.phone,
        color: Colors.white,
      ),
    );
  }

  IconButton userDeleteIcon(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final secilenUserState = context.read<SecilenUserCubit>().state;
        if (secilenUserState != null) {
          // Onay diyaloğunu göster
          bool confirm = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Silme Onayı"),
              content: const Text(
                  "Bu kullanıcıya ait tüm kayıtları silmek istediğinize emin misiniz?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false), // Hayır
                  child: const Text("Hayır"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true), // Evet
                  child: const Text("Evet"),
                ),
              ],
            ),
          );

          if (confirm == true) {
            // Borçları sil
            await context
                .read<BorcCubit>()
                .deleteAllBorcsByUser(secilenUserState);
            // Kullanıcıyı sil
            await context.read<UserAddCubit>().userDelete(secilenUserState);

            // Ana ekrana yönlendir
            context.go(AppRoutes.homeBorc);
          }
        } else {
          debugPrint("Seçilen kullanıcı bulunamadı.");
        }
      },
      icon: const Icon(Icons.delete),
    );
  }
}

String dateConvert(DateTime date) {
  return " ${date.day}/${date.month}/${date.year} ";
}
