import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hesapp/model/borc_model.dart';
import 'package:hesapp/model/odeme_model.dart';
import 'package:hesapp/model/user_model.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

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
    // Her çağrıda filtreleme listesini sıfırla
    filterList = [];

    for (var element in borcBox.values) {
      if (element.userModel.userID == userModel.userID) {
        filterList.add(element);
      }
    }
    emit(filterList);
  }

  Future<void> addOdeme(String borcID, double odenenTutar) async {
    // İlgili borç kaydını al
    var borc = borcBox.get(borcID);

    if (borc == null) return;

    // Yeni ödeme geçmişi kaydı oluştur
    var yeniOdeme = OdemeGecmisiModel(
      odmeID: const Uuid().v1(),
      anaPara: borc.borc,
      odenenPara: odenenTutar,
      kalanPara: borc.guncelBorc - odenenTutar,
      odemeTarihi: DateTime.now(),
    );

    // Borcun güncel halini oluştur
    if (borc.odemeGecmisi != null) {
      borc.odemeGecmisi!.add(yeniOdeme);
    } else {
      borc.odemeGecmisi = [yeniOdeme];
    }

    borc.guncelBorc -= odenenTutar;

    // Güncellenmiş borcu veritabanına kaydet
    await borcBox.put(borcID, borc);

    // Güncel listeyi emit et
    emit(borcBox.values.toList());
  }

  Future<void> deleteOdeme(
      String odmeID, String borcID, double odenenTutar) async {
    // İlgili borç kaydını al
    var borc = borcBox.get(borcID);

    if (borc == null) return;

    // Ödeme geçmişini kontrol et ve silinecek kaydı bul
    var odemeToDelete = borc.odemeGecmisi?.firstWhere(
      (odeme) => odeme.odmeID == odmeID,
    );

    if (odemeToDelete == null) return;

    // Silinen ödeme miktarını ana paraya geri ekle
    borc.guncelBorc += odenenTutar;

    // Ödeme geçmişinden silme işlemi
    borc.odemeGecmisi?.remove(odemeToDelete);

    // Güncellenmiş borcu veritabanına kaydet
    await borcBox.put(borcID, borc);

    // Güncel listeyi emit et
    emit(borcBox.values.toList());
  }

  deleteAllBorcsByUser(UserModel secilenUserState) {}
}
