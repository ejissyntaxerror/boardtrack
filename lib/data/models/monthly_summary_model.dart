import 'package:hive/hive.dart';

class BoarderMonthlySummary extends HiveObject {
  final String id;
  final String name;
  final String room;
  final double rent;
  final bool paid;
  final double feesTotal;
  final double balance; // unpaid rent + fees for the month

  BoarderMonthlySummary({
    required this.id,
    required this.name,
    required this.room,
    required this.rent,
    required this.paid,
    required this.feesTotal,
    required this.balance,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BoarderMonthlySummary &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          room == other.room &&
          rent == other.rent &&
          paid == other.paid &&
          feesTotal == other.feesTotal &&
          balance == other.balance;

  @override
  int get hashCode => Object.hash(id, name, room, rent, paid, feesTotal, balance);
}

class MonthlySummary extends HiveObject {
  final String month; // "YYYY-MM" or "all-time"
  final double totalCollected;
  final double totalUnpaid;
  final int unpaidCount;
  final double totalFees;
  final List<BoarderMonthlySummary> boarderSummaries;

  MonthlySummary({
    required this.month,
    required this.totalCollected,
    required this.totalUnpaid,
    required this.unpaidCount,
    required this.totalFees,
    required this.boarderSummaries,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MonthlySummary &&
          runtimeType == other.runtimeType &&
          month == other.month &&
          totalCollected == other.totalCollected &&
          totalUnpaid == other.totalUnpaid &&
          unpaidCount == other.unpaidCount &&
          totalFees == other.totalFees &&
          _listEquals(boarderSummaries, other.boarderSummaries);

  @override
  int get hashCode => Object.hash(month, totalCollected, totalUnpaid, unpaidCount, totalFees, Object.hashAll(boarderSummaries));

  static bool _listEquals<T>(List<T> a, List<T> b) {
    if (identical(a, b)) return true;
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
