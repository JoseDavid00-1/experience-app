import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/fake_payment_repository.dart';
import '../domain/entities/payment_method.dart';
import '../domain/repositories/payment_repository.dart';
import 'checkout_controller.dart';
import 'checkout_state.dart';

final paymentRepositoryProvider = Provider<PaymentRepository>((ref) {
  return const FakePaymentRepository();
});

final paymentMethodsProvider = FutureProvider<List<PaymentMethod>>((ref) {
  return ref.watch(paymentRepositoryProvider).getAvailableMethods();
});

final checkoutControllerProvider =
    NotifierProvider<CheckoutController, CheckoutState>(CheckoutController.new);
