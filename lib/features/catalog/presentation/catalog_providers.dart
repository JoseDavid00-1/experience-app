import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/datasources/product_local_datasource.dart';
import '../data/repositories/product_repository_impl.dart';
import '../domain/entities/product.dart';
import '../domain/repositories/product_repository.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepositoryImpl(const ProductLocalDatasource());
});

final productsProvider = FutureProvider<List<Product>>((ref) {
  return ref.watch(productRepositoryProvider).getProducts();
});

final productByIdProvider = FutureProvider.family<Product?, String>((ref, id) {
  return ref.watch(productRepositoryProvider).getProductById(id);
});
