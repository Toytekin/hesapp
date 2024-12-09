// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'odeme_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OdemeGecmisiModelAdapter extends TypeAdapter<OdemeGecmisiModel> {
  @override
  final int typeId = 3;

  @override
  OdemeGecmisiModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OdemeGecmisiModel(
      odmeID: fields[0] as String,
      anaPara: fields[1] as double,
      odenenPara: fields[2] as double,
      kalanPara: fields[3] as double,
      odemeTarihi: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, OdemeGecmisiModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.odmeID)
      ..writeByte(1)
      ..write(obj.anaPara)
      ..writeByte(2)
      ..write(obj.odenenPara)
      ..writeByte(3)
      ..write(obj.kalanPara)
      ..writeByte(4)
      ..write(obj.odemeTarihi);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OdemeGecmisiModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
