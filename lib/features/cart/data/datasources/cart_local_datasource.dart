import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CartLocalDatasource {
  const CartLocalDatasource(this._preferences);

  static const _storageKey = 'cart.items.v1';
  final SharedPreferencesAsync _preferences;

  Future<Map<String, int>?> readItems() async {
    final raw = await _preferences.getString(_storageKey);
    if (raw == null || raw.isEmpty) return null;

    final decoded = jsonDecode(raw);
    if (decoded is! Map<String, dynamic>) return null;
    return decoded.map((key, value) => MapEntry(key, value as int));
  }

  Future<void> writeItems(Map<String, int> items) {
    return _preferences.setString(_storageKey, jsonEncode(items));
  }
}
