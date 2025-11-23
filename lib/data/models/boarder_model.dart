import 'package:hive/hive.dart';

part '...existing code...'; // no codegen; placeholder to indicate file region

class Fee extends HiveObject {
  String id;
  String name;
  double amount;
  DateTime createdAt;

  Fee({required this.id, required this.name, required this.amount, DateTime? createdAt})
      : createdAt = createdAt ?? DateTime.now();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Fee &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          amount == other.amount &&
          createdAt == other.createdAt;

  @override
  int get hashCode => Object.hash(id, name, amount, createdAt);
}

class PaymentRecord extends HiveObject {
  String month; // "YYYY-MM"
  bool paid;
  DateTime updatedAt;

  PaymentRecord({required this.month, required this.paid, DateTime? updatedAt})
      : updatedAt = updatedAt ?? DateTime.now();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentRecord &&
          runtimeType == other.runtimeType &&
          month == other.month &&
          paid == other.paid &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode => Object.hash(month, paid, updatedAt);
}

class Boarder extends HiveObject {
  String id;
  String name;
  String room;
  double rent;
  List<Fee> fees;
  List<PaymentRecord> payments;
  DateTime createdAt;

  Boarder({
    required this.id,
    required this.name,
    required this.room,
    required this.rent,
    List<Fee>? fees,
    List<PaymentRecord>? payments,
    DateTime? createdAt,
  })  : fees = fees ?? [],
        payments = payments ?? [],
        createdAt = createdAt ?? DateTime.now();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Boarder &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          room == other.room &&
          rent == other.rent &&
          _listEquals(fees, other.fees) &&
          _listEquals(payments, other.payments) &&
          createdAt == other.createdAt;

  @override
  int get hashCode => Object.hash(id, name, room, rent, Object.hashAll(fees), Object.hashAll(payments), createdAt);

  static bool _listEquals<T>(List<T> a, List<T> b) {
    if (identical(a, b)) return true;
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}

/* --------------------------
   Manual Hive TypeAdapters
   typeId assignments:
   Boarder -> 0
   Fee -> 1
   PaymentRecord -> 2
   -------------------------- */

class FeeAdapter extends TypeAdapter<Fee> {
  @override
  final int typeId = 1;

  @override
  Fee read(BinaryReader reader) {
    final id = reader.readString();
    final name = reader.readString();
    final amount = reader.readDouble();
    final createdAt = DateTime.fromMillisecondsSinceEpoch(reader.readInt());
    return Fee(id: id, name: name, amount: amount, createdAt: createdAt);
  }

  @override
  void write(BinaryWriter writer, Fee obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.name);
    writer.writeDouble(obj.amount);
    writer.writeInt(obj.createdAt.millisecondsSinceEpoch);
  }
}

class PaymentRecordAdapter extends TypeAdapter<PaymentRecord> {
  @override
  final int typeId = 2;

  @override
  PaymentRecord read(BinaryReader reader) {
    final month = reader.readString();
    final paid = reader.readBool();
    final updatedAt = DateTime.fromMillisecondsSinceEpoch(reader.readInt());
    return PaymentRecord(month: month, paid: paid, updatedAt: updatedAt);
  }

  @override
  void write(BinaryWriter writer, PaymentRecord obj) {
    writer.writeString(obj.month);
    writer.writeBool(obj.paid);
    writer.writeInt(obj.updatedAt.millisecondsSinceEpoch);
  }
}

class BoarderAdapter extends TypeAdapter<Boarder> {
  @override
  final int typeId = 0;

  @override
  Boarder read(BinaryReader reader) {
    final id = reader.readString();
    final name = reader.readString();
    final room = reader.readString();
    final rent = reader.readDouble();

    final feesCount = reader.readInt();
    final fees = <Fee>[];
    for (var i = 0; i < feesCount; i++) {
      fees.add(reader.read() as Fee);
    }

    final paymentsCount = reader.readInt();
    final payments = <PaymentRecord>[];
    for (var i = 0; i < paymentsCount; i++) {
      payments.add(reader.read() as PaymentRecord);
    }

    final createdAt = DateTime.fromMillisecondsSinceEpoch(reader.readInt());
    return Boarder(id: id, name: name, room: room, rent: rent, fees: fees, payments: payments, createdAt: createdAt);
  }

  @override
  void write(BinaryWriter writer, Boarder obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.name);
    writer.writeString(obj.room);
    writer.writeDouble(obj.rent);

    writer.writeInt(obj.fees.length);
    for (final f in obj.fees) {
      writer.write(f);
    }

    writer.writeInt(obj.payments.length);
    for (final p in obj.payments) {
      writer.write(p);
    }

    writer.writeInt(obj.createdAt.millisecondsSinceEpoch);
  }
}