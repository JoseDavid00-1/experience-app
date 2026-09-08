import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  const ProductRepositoryImpl(this._datasource);

  final ProductLocalDatasource _datasource;

  @override
  Future<List<Product>> getProducts() => _datasource.getProducts();

  @override
  Future<Product?> getProductById(String productId) async {
    final products = await getProducts();
    for (final product in products) {
      if (product.id == productId) return product;
    }
    return null;
  }
}
