import 'promotional_banner.dart';
import 'product_section.dart';

class HomeContent {
  const HomeContent({required this.banners, required this.sections});

  final List<PromotionalBanner> banners;
  final List<ProductSection> sections;
}
