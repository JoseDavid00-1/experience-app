import '../../../catalog/domain/entities/product.dart';

class CartLine {
  const CartLine({
    required this.key,
    required this.product,
    required this.quantity,
    this.size,
    this.colorId,
  });

  final String key;
  final Product product;
  final int quantity;
  final String? size;
  final String? colorId;

  String get variantLabel {
    final values = [size, colorId].whereType<String>().toList(growable: false);
    return values.isEmpty ? 'Standard' : values.join(' / ');
  }

  int get subtotalInCents => product.priceInCents * quantity;
}
