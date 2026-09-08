import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/cart/presentation/cart_provider.dart';
import '../../features/home/domain/entities/home_content.dart';
import '../../features/home/presentation/home_providers.dart';
import '../../features/home/presentation/widgets/home_app_bar.dart';
import '../../features/home/presentation/widgets/home_state_views.dart';
import '../../features/home/presentation/widgets/product_section.dart';
import '../../features/home/presentation/widgets/promotional_carousel.dart';
import '../router/route_names.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final content = ref.watch(homeContentProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HomeAppBar(
        cartItemCount: ref.watch(cartItemCountProvider),
        onSearchPressed: () => context.pushNamed(RouteNames.search),
        onFavoritesPressed: () => context.pushNamed(RouteNames.favorites),
        onCartPressed: () => context.pushNamed(RouteNames.cart),
      ),
      body: content.when(
        loading: () => const HomeLoadingView(),
        error: (error, stackTrace) =>
            HomeErrorView(onRetry: () => ref.invalidate(homeContentProvider)),
        data: (HomeContent homeContent) {
          if (homeContent.sections.every(
            (section) => section.products.isEmpty,
          )) {
            return const HomeEmptyView();
          }
          return _HomeContent(
            content: homeContent,
            onProductPressed: (productId) => context.pushNamed(
              RouteNames.productDetail,
              pathParameters: {'productId': productId},
            ),
            onSeeMorePressed: (sectionId) => context.pushNamed(
              RouteNames.catalog,
              queryParameters: {'section': sectionId},
            ),
          );
        },
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({
    required this.content,
    required this.onProductPressed,
    required this.onSeeMorePressed,
  });

  final HomeContent content;
  final ValueChanged<String> onProductPressed;
  final ValueChanged<String> onSeeMorePressed;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth > 720
            ? 720.0
            : constraints.maxWidth;
        return Center(
          child: SizedBox(
            width: maxWidth,
            child: CustomScrollView(
              key: const PageStorageKey<String>('home-scroll'),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  sliver: SliverToBoxAdapter(
                    child: PromotionalCarousel(banners: content.banners),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final section = content.sections[index];
                    if (section.products.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: ProductSectionWidget(
                        section: section,
                        onProductPressed: onProductPressed,
                        onSeeMorePressed: onSeeMorePressed,
                      ),
                    );
                  }, childCount: content.sections.length),
                ),
                const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
              ],
            ),
          ),
        );
      },
    );
  }
}
