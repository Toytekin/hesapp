import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hesapp/constant/colors.dart';
import 'package:hesapp/cubit/borc_cubit.dart';
import 'package:hesapp/model/borc_model.dart';
import 'package:hesapp/model/odeme_model.dart';
import 'package:hesapp/widget/textfild.dart';

class BorcCard extends StatefulWidget {
  final BorcModel item;

  const BorcCard({super.key, required this.item});

  @override
  // ignore: library_private_types_in_public_api
  _BorcCardState createState() => _BorcCardState();
}

class _BorcCardState extends State<BorcCard> {
  bool showOdemeGecmisi = false;
  final today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: SbtAppColors.accentColor,
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 8),
            _buildBorcDetails(),
            const SizedBox(height: 16),
            _buildOdemeButton(context),
            if (showOdemeGecmisi) _buildOdemeGecmisi(),
          ],
        ),
      ),
    );
  }

  // Kart başlığı
  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () => _confirmDelete(context),
        ),
        Text(
          widget.item.borcName,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
        ),
        IconButton(
          icon: Icon(
            showOdemeGecmisi ? Icons.expand_less : Icons.expand_more,
            color: Colors.green.shade600,
          ),
          onPressed: () => setState(() {
            showOdemeGecmisi = !showOdemeGecmisi;
          }),
        ),
      ],
    );
  }

  // Borç detayları
  Widget _buildBorcDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailText('Alınan Borç', '${widget.item.borc} TL'),
        _buildDetailText('Güncel Borç', '${widget.item.guncelBorc} TL'),
        _buildDetailText(
            'Alınan Tarih', dateConvert(widget.item.borcAlinanTarih)),
        _buildDetailText(
          'Ödenecek Tarih',
          dateConvert(widget.item.odenecekSonTarih!),
          color: _getTarihColor(widget.item.odenecekSonTarih!),
        ),
      ],
    );
  }

  // Ödeme butonu
  Widget _buildOdemeButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () => _showOdemeDialog(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
        child: const Text(
          'Ödeme Yap',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ),
    );
  }

  // Ödeme geçmişi
  Widget _buildOdemeGecmisi() {
    return Column(
      children: [
        const Divider(color: Colors.green, height: 4),
        if (widget.item.odemeGecmisi != null &&
            widget.item.odemeGecmisi!.isNotEmpty)
          ...widget.item.odemeGecmisi!.map((odeme) => _odemeGecmisiCard(odeme))
        else
          const Text(
            'Henüz bir ödeme yapılmadı.',
            style: TextStyle(color: Colors.grey),
          ),
      ],
    );
  }

  // Tek bir ödeme geçmişi kartı
  Widget _odemeGecmisiCard(OdemeGecmisiModel odeme) {
    return Card(
      color: Colors.white,
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRow(
                'Ödenen Para', '${odeme.odenenPara.toStringAsFixed(2)} TL',
                isBold: true),
            _buildRow('Ana Para', '${odeme.anaPara.toStringAsFixed(2)} TL'),
            _buildRow(
              'Kalan Para',
              '${odeme.kalanPara.toStringAsFixed(2)} TL',
              color: odeme.kalanPara == 0 ? Colors.green : Colors.red,
            ),
            _buildRow('Ödeme Tarihi', dateConvert(odeme.odemeTarihi)),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(Icons.delete, color: Colors.red.shade600),
                onPressed: () => _confirmDeleteOdeme(context, odeme),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Metin detayları
  Widget _buildDetailText(String label, String value, {Color? color}) {
    return Text(
      '$label: $value',
      style: TextStyle(fontSize: 14, color: color ?? Colors.black54),
    );
  }

  // Satır oluşturucu
  Widget _buildRow(String label, String value,
      {Color color = Colors.black, bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        Text(
          value,
          style: TextStyle(
              fontSize: 14,
              color: color,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
        ),
      ],
    );
  }

  // Tarih için renk belirleyici
  Color _getTarihColor(DateTime tarih) {
    return (tarih.year == today.year &&
            tarih.month == today.month &&
            tarih.day == today.day)
        ? Colors.redAccent
        : Colors.black;
  }

  // Tarih formatlama
  String dateConvert(DateTime dateTime) {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }

  // Silme onayı
  void _confirmDelete(BuildContext context) {
    _showConfirmationDialog(
      context,
      'Silmek istediğinizden emin misiniz?',
      onConfirm: () {
        context.read<BorcCubit>().borcDelete(widget.item);
        Navigator.pop(context);
      },
    );
  }

  // Ödeme silme onayı
  void _confirmDeleteOdeme(BuildContext context, OdemeGecmisiModel odeme) {
    _showConfirmationDialog(
      context,
      'Silmek istediğinizden emin misiniz?',
      onConfirm: () {
        context
            .read<BorcCubit>()
            .deleteOdeme(odeme.odmeID, widget.item.borcID, odeme.odenenPara);
        Navigator.pop(context);
      },
    );
  }

  // Genel onay diyaloğu
  void _showConfirmationDialog(BuildContext context, String message,
      {required VoidCallback onConfirm}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: onConfirm,
              child: const Text('Sil'),
            ),
          ],
        );
      },
    );
  }

  // Ödeme yapma diyaloğu
  void _showOdemeDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Ödeme Yap"),
          content: SbtTextField(
            controller: controller,
            icon: const Icon(Icons.money_rounded),
            label: 'Ödeme Miktarı',
            keybordNumbber: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("İptal"),
            ),
            TextButton(
              onPressed: () {
                final enteredAmount = double.tryParse(controller.text);
                if (enteredAmount != null && enteredAmount > 0) {
                  context.read<BorcCubit>().addOdeme(
                        widget.item.borcID,
                        enteredAmount,
                      );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Geçerli bir tutar girin."),
                    ),
                  );
                }
              },
              child: const Text(
                "Ödeme Yap",
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }
}
