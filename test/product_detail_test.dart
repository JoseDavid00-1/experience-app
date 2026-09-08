import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:experience_app/app/pages/product_detail_page.dart';
import 'package:experience_app/features/cart/presentation/cart_provider.dart';
import 'package:experience_app/features/favorites/presentation/favorites_provider.dart';

void main() {
  testWidgets('deep link renders the product detail and adds a variant', (
    tester,
  ) async {
    final cart = TestCartController();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [cartProvider.overrideWith(() => cart)],
        child: MaterialApp.router(routerConfig: _detailRouter()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Amazing T-shirt'), findsOneWidget);
    expect(find.text('€ 12.00'), findsOneWidget);
    expect(find.text('Add to bag'), findsOneWidget);

    await tester.tap(find.text('Add to bag'));
    await tester.pumpAndSettle();

    expect(cart.state['amazing-t-shirt|S|blue'], 1);
    expect(find.text('Added to bag'), findsOneWidget);
  });

  testWidgets('favorite button toggles the existing favorites provider', (
    tester,
  ) async {
    final favorites = TestFavoritesController();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [favoritesProvider.overrideWith(() => favorites)],
        child: const MaterialApp(
          home: ProductDetailPage(productId: 'amazing-t-shirt'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Add to favorites'));
    await tester.pump();

    expect(favorites.state, contains('amazing-t-shirt'));
    expect(find.byTooltip('Remove from favorites'), findsOneWidget);
  });

  testWidgets('unknown product shows the not found state', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: ProductDetailPage(productId: 'does-not-exist'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Product not found.'), findsOneWidget);
  });
}

GoRouter _detailRouter() {
  return GoRouter(
    initialLocation: '/products/amazing-t-shirt',
    routes: [
      GoRoute(
        path: '/products/:productId',
        builder: (context, state) =>
            ProductDetailPage(productId: state.pathParameters['productId']!),
      ),
    ],
  );
}

class TestCartController extends CartController {
  @override
  Map<String, int> build() => {};
}

class TestFavoritesController extends FavoritesController {
  @override
  Set<String> build() => {};
}
