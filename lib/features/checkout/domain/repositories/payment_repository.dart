import '../entities/payment_method.dart';
import '../entities/payment_result.dart';

abstract interface class PaymentRepository {
  Future<List<PaymentMethod>> getAvailableMethods();

  Future<PaymentResult> processPayment({
    required String paymentMethodId,
    required int amountInCents,
    required bool billingMatchesShipping,
  });
}
