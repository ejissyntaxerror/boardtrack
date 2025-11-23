import 'package:hive/hive.dart';

part 'dashboard_summary_model.g.dart';

@HiveType(typeId: 1)
class DashboardSummaryModel extends HiveObject {
  @HiveField(0)
  final double totalRentCollected;

  @HiveField(1)
  final double totalUnpaidRent;

  @HiveField(2)
  final int unpaidBoarderCount;

  DashboardSummaryModel({
    required this.totalRentCollected,
    required this.totalUnpaidRent,
    required this.unpaidBoarderCount,
  });

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is DashboardSummaryModel &&
            runtimeType == other.runtimeType &&
            totalRentCollected == other.totalRentCollected &&
            totalUnpaidRent == other.totalUnpaidRent &&
            unpaidBoarderCount == other.unpaidBoarderCount;
  }

  @override
  int get hashCode =>
      totalRentCollected.hashCode ^
      totalUnpaidRent.hashCode ^
      unpaidBoarderCount.hashCode;
}
