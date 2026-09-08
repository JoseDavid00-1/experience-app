import 'product_color.dart';

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.priceInCents,
    required this.currencyCode,
    required this.isAvailable,
    this.imageAsset,
    this.description = '',
    this.imageAssets = const [],
    this.availableSizes = const [],
    this.availableColors = const [],
  });

  final String id;
  final String name;
  final int priceInCents;
  final String currencyCode;
  final bool isAvailable;
  final String? imageAsset;
  final String description;
  final List<String> imageAssets;
  final List<String> availableSizes;
  final List<ProductColor> availableColors;
}
