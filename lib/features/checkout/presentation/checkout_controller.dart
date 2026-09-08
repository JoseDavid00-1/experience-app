import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../cart/presentation/cart_provider.dart';
import 'checkout_providers.dart';
import 'checkout_state.dart';

class CheckoutController extends Notifier<CheckoutState> {
  @override
  CheckoutState build() => const CheckoutState();

  void selectPaymentMethod(String methodId) {
    state = state.copyWith(selectedPaymentMethodId: methodId, clearError: true);
  }

  void setBillingMatchesShipping(bool value) {
    state = state.copyWith(billingMatchesShipping: value, clearError: true);
  }

  Future<bool> processPayment() async {
    final methodId = state.selectedPaymentMethodId;
    if (state.isProcessing) return false;
    if (methodId == null) {
      state = state.copyWith(errorMessage: 'Select a payment method.');
      return false;
    }

    final amount = ref.read(cartTotalProvider);
    if (amount <= 0) {
      state = state.copyWith(errorMessage: 'Your bag is empty.');
      return false;
    }

    state = state.copyWith(isProcessing: true, clearError: true);
    final result = await ref
        .read(paymentRepositoryProvider)
        .processPayment(
          paymentMethodId: methodId,
          amountInCents: amount,
          billingMatchesShipping: state.billingMatchesShipping,
        );
    state = state.copyWith(
      isProcessing: false,
      errorMessage: result.success ? null : result.message,
      clearError: result.success,
    );
    return result.success;
  }
}
