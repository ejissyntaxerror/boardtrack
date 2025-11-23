// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boarder_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BoarderModelAdapter extends TypeAdapter<BoarderModel> {
  @override
  final int typeId = 0;

  @override
  BoarderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BoarderModel(
      id: fields[0] as String,
      name: fields[1] as String,
      room: fields[2] as String,
      rent: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BoarderModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.room)
      ..writeByte(3)
      ..write(obj.rent);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BoarderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
