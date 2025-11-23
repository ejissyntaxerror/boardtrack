import '../../data/models/boarder_model.dart';

abstract class PaymentLocalDataSource {
  /// Set or update the payment status for a boarder for a given month ("YYYY-MM")
  Future<void> setPaymentStatus(String boarderId, String yearMonth, bool paid);

  /// Get a single payment record for a boarder for a month (or null if none)
  Future<PaymentRecord?> getPaymentForMonth(String boarderId, String yearMonth);

  /// Get full payment history for a boarder
  Future<List<PaymentRecord>> getPaymentHistory(String boarderId);
}
