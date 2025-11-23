// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_summary_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DashboardSummaryModelAdapter extends TypeAdapter<DashboardSummaryModel> {
  @override
  final int typeId = 1;

  @override
  DashboardSummaryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DashboardSummaryModel(
      totalRentCollected: fields[0] as double,
      totalUnpaidRent: fields[1] as double,
      unpaidBoarderCount: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, DashboardSummaryModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.totalRentCollected)
      ..writeByte(1)
      ..write(obj.totalUnpaidRent)
      ..writeByte(2)
      ..write(obj.unpaidBoarderCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DashboardSummaryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
