import '../../../catalog/data/datasources/product_local_datasource.dart';
import '../../domain/entities/home_content.dart';
import '../../domain/entities/product_section.dart';
import '../../domain/entities/promotional_banner.dart';

class HomeLocalDatasource {
  const HomeLocalDatasource(this._productsDatasource);

  final ProductLocalDatasource _productsDatasource;

  Future<HomeContent> getContent() async {
    final products = await _productsDatasource.getProducts();
    return HomeContent(
      banners: const [
        PromotionalBanner(id: 'banner-1'),
        PromotionalBanner(id: 'banner-2'),
        PromotionalBanner(id: 'banner-3'),
        PromotionalBanner(id: 'banner-4'),
        PromotionalBanner(id: 'banner-5'),
      ],
      sections: [
        ProductSection(
          id: 'recommended',
          title: 'Perfect for you',
          products: products.take(2).toList(growable: false),
        ),
        ProductSection(
          id: 'summer',
          title: 'For this summer',
          products: products.skip(2).toList(growable: false),
        ),
      ],
    );
  }
}
