import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:experience_app/app/pages/home_page.dart';
import 'package:experience_app/core/formatters/currency_formatter.dart';
import 'package:experience_app/features/cart/presentation/cart_provider.dart';

void main() {
  test('formats cents as euros', () {
    expect(formatCurrency(1200, 'EUR'), '€ 12.00');
  });

  testWidgets('home renders banners, sections, products and cart badge', (
    tester,
  ) async {
    await _pumpHome(tester);
    await tester.pumpAndSettle();

    expect(find.text('Perfect for you'), findsOneWidget);
    expect(find.byType(PageView), findsOneWidget);
    await tester.drag(
      find.byKey(const PageStorageKey<String>('home-scroll')),
      const Offset(0, -400),
    );
    await tester.pumpAndSettle();
    expect(find.text('For this summer'), findsOneWidget);
    expect(find.text('Amazing T-shirt'), findsOneWidget);
    expect(find.text('€ 12.00'), findsOneWidget);
    expect(find.text('See more'), findsNWidgets(2));
    expect(find.text('9'), findsOneWidget);
  });

  testWidgets('tapping a product opens detail with its ID', (tester) async {
    await tester.pumpWidget(
      ProviderScope(child: MaterialApp.router(routerConfig: _homeRouter())),
    );
    await tester.pumpAndSettle();

    await tester.drag(
      find.byKey(const PageStorageKey<String>('home-scroll')),
      const Offset(0, -400),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Amazing T-shirt'));
    await tester.pumpAndSettle();

    expect(find.text('amazing-t-shirt'), findsOneWidget);
  });

  testWidgets('carousel changes its semantic page after a swipe', (
    tester,
  ) async {
    await _pumpHome(tester);
    await tester.pumpAndSettle();

    await tester.fling(find.byType(PageView), const Offset(-300, 0), 1000);
    await tester.pumpAndSettle();

    expect(
      find.byKey(const ValueKey<String>('carousel-dot-1-active')),
      findsOneWidget,
    );
  });

  testWidgets('cart badge can be hidden when cart is empty', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [cartProvider.overrideWith(() => EmptyCartController())],
        child: const MaterialApp(home: _CartBadgeHarness()),
      ),
    );
    await tester.pump();

    expect(find.byType(Badge), findsOneWidget);
    expect(find.text('0'), findsNothing);
  });
}

Future<void> _pumpHome(WidgetTester tester) async {
  await tester.pumpWidget(
    const ProviderScope(child: MaterialApp(home: HomePage())),
  );
}

GoRouter _homeRouter() {
  return GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(path: '/home', builder: (context, state) => const HomePage()),
      GoRoute(
        name: 'product-detail',
        path: '/products/:productId',
        builder: (context, state) => Text(state.pathParameters['productId']!),
      ),
    ],
  );
}

class EmptyCartController extends CartController {
  @override
  Map<String, int> build() => const {};
}

class _CartBadgeHarness extends StatelessWidget {
  const _CartBadgeHarness();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final count = ref.watch(cartItemCountProvider);
        return Scaffold(
          appBar: AppBar(
            actions: [
              Badge(
                isLabelVisible: count > 0,
                label: Text('$count'),
                child: const Icon(Icons.shopping_bag_outlined),
              ),
            ],
          ),
        );
      },
    );
  }
}
