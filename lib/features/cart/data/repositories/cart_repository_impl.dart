import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_local_datasource.dart';

class CartRepositoryImpl implements CartRepository {
  const CartRepositoryImpl(this._datasource);

  final CartLocalDatasource _datasource;

  @override
  Future<Map<String, int>?> readItems() => _datasource.readItems();

  @override
  Future<void> saveItems(Map<String, int> items) =>
      _datasource.writeItems(items);
}

class InMemoryCartRepository implements CartRepository {
  Map<String, int>? _items;

  @override
  Future<Map<String, int>?> readItems() async => _items;

  @override
  Future<void> saveItems(Map<String, int> items) async {
    _items = Map.unmodifiable(items);
  }
}
