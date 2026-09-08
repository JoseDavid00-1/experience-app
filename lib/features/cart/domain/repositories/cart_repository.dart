abstract interface class CartRepository {
  Future<Map<String, int>?> readItems();

  Future<void> saveItems(Map<String, int> items);
}
