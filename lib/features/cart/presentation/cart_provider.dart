import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../catalog/presentation/catalog_providers.dart';
import '../data/datasources/cart_local_datasource.dart';
import '../data/repositories/cart_repository_impl.dart';
import '../domain/entities/cart_line.dart';
import '../domain/repositories/cart_repository.dart';

final cartRepositoryProvider = Provider<CartRepository>((ref) {
  try {
    return CartRepositoryImpl(CartLocalDatasource(SharedPreferencesAsync()));
  } catch (_) {
    return InMemoryCartRepository();
  }
});

class CartController extends Notifier<Map<String, int>> {
  bool _restoring = false;

  @override
  Map<String, int> build() {
    if (!_restoring) {
      _restoring = true;
      Future<void>(() async {
        try {
          final saved = await ref.read(cartRepositoryProvider).readItems();
          if (saved != null) state = saved;
        } catch (_) {
          // Keep the local demo cart when persistence is unavailable.
        }
      });
    }
    return const {
      'amazing-t-shirt': 3,
      'fabulous-pants': 2,
      'light-summer-shirt': 4,
    };
  }

  int get itemCount => state.values.fold(0, (sum, quantity) => sum + quantity);

  void add(String productId, {String? size, String? color, int quantity = 1}) {
    if (quantity <= 0) return;
    final variantKey = [productId, size, color].whereType<String>().join('|');
    final key = variantKey.isEmpty ? productId : variantKey;
    _setItems({...state, key: (state[key] ?? 0) + quantity});
  }

  void increase(String key) {
    _setItems({...state, key: (state[key] ?? 0) + 1});
  }

  void decrease(String key) {
    final current = state[key] ?? 0;
    if (current <= 1) {
      remove(key);
      return;
    }
    _setItems({...state, key: current - 1});
  }

  void remove(String key) {
    final next = {...state}..remove(key);
    _setItems(next);
  }

  void _setItems(Map<String, int> items) {
    state = Map.unmodifiable(items);
    Future<void>(() async {
      try {
        await ref.read(cartRepositoryProvider).saveItems(state);
      } catch (_) {
        // The in-memory state remains usable if storage is unavailable.
      }
    });
  }
}

final cartProvider = NotifierProvider<CartController, Map<String, int>>(
  CartController.new,
);

final cartItemCountProvider = Provider<int>((ref) {
  return ref.watch(
    cartProvider.select((items) {
      return items.values.fold(0, (sum, quantity) => sum + quantity);
    }),
  );
});

final cartLinesProvider = FutureProvider<List<CartLine>>((ref) async {
  final items = ref.watch(cartProvider);
  final products = await ref.watch(productsProvider.future);
  final productsById = {for (final product in products) product.id: product};

  return items.entries
      .map((entry) {
        final parts = entry.key.split('|');
        final product = productsById[parts.first];
        if (product == null) return null;
        return CartLine(
          key: entry.key,
          product: product,
          quantity: entry.value,
          size: parts.length > 1 ? parts[1] : null,
          colorId: parts.length > 2 ? parts[2] : null,
        );
      })
      .whereType<CartLine>()
      .toList(growable: false);
});

final cartTotalProvider = Provider<int>((ref) {
  final lines = ref
      .watch(cartLinesProvider)
      .maybeWhen(data: (value) => value, orElse: () => const <CartLine>[]);
  return lines.fold(0, (total, line) => total + line.subtotalInCents);
});
