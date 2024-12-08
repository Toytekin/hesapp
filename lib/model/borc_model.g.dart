// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'borc_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BorcModelAdapter extends TypeAdapter<BorcModel> {
  @override
  final int typeId = 2;

  @override
  BorcModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BorcModel(
      borcID: fields[1] as String,
      userModel: fields[0] as UserModel,
      borcName: fields[2] as String,
      borc: fields[3] as double,
      borcAlinanTarih: fields[4] as DateTime,
      odenecekSonTarih: fields[6] as DateTime?,
      odemeTarihi: fields[5] as DateTime?,
      borcOdemeDurumu: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, BorcModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.userModel)
      ..writeByte(1)
      ..write(obj.borcID)
      ..writeByte(2)
      ..write(obj.borcName)
      ..writeByte(3)
      ..write(obj.borc)
      ..writeByte(4)
      ..write(obj.borcAlinanTarih)
      ..writeByte(5)
      ..write(obj.odemeTarihi)
      ..writeByte(6)
      ..write(obj.odenecekSonTarih)
      ..writeByte(7)
      ..write(obj.borcOdemeDurumu);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BorcModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
