import '../../domain/entities/home_content.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_local_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl(this._datasource);

  final HomeLocalDatasource _datasource;

  @override
  Future<HomeContent> getContent() => _datasource.getContent();
}
