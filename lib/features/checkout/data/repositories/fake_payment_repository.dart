import '../../domain/entities/payment_method.dart';
import '../../domain/entities/payment_result.dart';
import '../../domain/repositories/payment_repository.dart';

class FakePaymentRepository implements PaymentRepository {
  const FakePaymentRepository();

  @override
  Future<List<PaymentMethod>> getAvailableMethods() async {
    return const [
      PaymentMethod(
        id: 'saved-card',
        label: 'Credit Card',
        type: PaymentMethodType.card,
        lastFour: '4242',
      ),
      PaymentMethod(
        id: 'apple-pay',
        label: 'Apple Pay',
        type: PaymentMethodType.applePay,
      ),
    ];
  }

  @override
  Future<PaymentResult> processPayment({
    required String paymentMethodId,
    required int amountInCents,
    required bool billingMatchesShipping,
  }) async {
    if (amountInCents <= 0) {
      return const PaymentResult(success: false, message: 'Your bag is empty.');
    }
    return const PaymentResult(
      success: true,
      message: 'Payment completed in demo mode.',
    );
  }
}
