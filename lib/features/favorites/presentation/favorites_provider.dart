import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesController extends Notifier<Set<String>> {
  @override
  Set<String> build() => <String>{};

  void toggle(String productId) {
    final next = Set<String>.from(state);
    if (!next.add(productId)) next.remove(productId);
    state = Set.unmodifiable(next);
  }
}

final favoritesProvider = NotifierProvider<FavoritesController, Set<String>>(
  FavoritesController.new,
);

final isFavoriteProvider = Provider.family<bool, String>((ref, productId) {
  return ref.watch(favoritesProvider.select((ids) => ids.contains(productId)));
});
