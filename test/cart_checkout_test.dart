import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:experience_app/features/cart/presentation/cart_provider.dart';
import 'package:experience_app/features/cart/presentation/pages/cart_page.dart';
import 'package:experience_app/features/checkout/presentation/pages/checkout_payment_page.dart';
import 'package:experience_app/features/checkout/presentation/pages/checkout_success_page.dart';

void main() {
  testWidgets('your bag updates quantity and removes an item at zero', (
    tester,
  ) async {
    final cart = TestCartController();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [cartProvider.overrideWith(() => cart)],
        child: const MaterialApp(home: CartPage()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Amazing T-shirt'), findsOneWidget);
    expect(find.text('€ 12.00'), findsOneWidget);

    cart.decrease('amazing-t-shirt');
    await tester.pumpAndSettle();
    await tester.pump();
    expect(cart.state['amazing-t-shirt'], 1);

    cart.decrease('amazing-t-shirt');
    await tester.pumpAndSettle();
    await tester.pump();
    expect(cart.state.containsKey('amazing-t-shirt'), isFalse);
  });

  testWidgets('payment can select a method and finish the demo checkout', (
    tester,
  ) async {
    final router = GoRouter(
      initialLocation: '/checkout/payment',
      routes: [
        GoRoute(
          path: '/checkout/payment',
          builder: (context, state) => const CheckoutPaymentPage(),
        ),
        GoRoute(
          name: 'checkout-success',
          path: '/checkout/success',
          builder: (context, state) => const CheckoutSuccessPage(),
        ),
      ],
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [cartProvider.overrideWith(TestCartController.new)],
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Payment'), findsNWidgets(2));
    expect(find.text('Credit Card'), findsOneWidget);
    expect(find.text('Apple Pay'), findsOneWidget);

    await tester.tap(find.text('Pay securely'));
    await tester.pumpAndSettle();

    expect(find.text('Payment successful'), findsOneWidget);
  });
}

class TestCartController extends CartController {
  @override
  Map<String, int> build() => {'amazing-t-shirt': 2};
}
