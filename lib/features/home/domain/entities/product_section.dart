import '../../../catalog/domain/entities/product.dart';

class ProductSection {
  const ProductSection({
    required this.id,
    required this.title,
    required this.products,
  });

  final String id;
  final String title;
  final List<Product> products;
}
