import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../catalog/data/datasources/product_local_datasource.dart';
import '../data/datasources/home_local_datasource.dart';
import '../data/repositories/home_repository_impl.dart';
import '../domain/entities/home_content.dart';
import '../domain/repositories/home_repository.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepositoryImpl(
    const HomeLocalDatasource(ProductLocalDatasource()),
  );
});

final homeContentProvider = FutureProvider<HomeContent>((ref) {
  return ref.watch(homeRepositoryProvider).getContent();
});
