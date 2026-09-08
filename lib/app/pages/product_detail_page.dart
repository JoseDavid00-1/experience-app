import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/catalog/presentation/catalog_providers.dart';
import '../../features/catalog/presentation/controllers/product_detail_providers.dart';
import '../../features/catalog/presentation/widgets/product_color_selector.dart';
import '../../features/catalog/presentation/widgets/product_detail_bottom_bar.dart';
import '../../features/catalog/presentation/widgets/product_detail_error_view.dart';
import '../../features/catalog/presentation/widgets/product_detail_header.dart';
import '../../features/catalog/presentation/widgets/product_image_carousel.dart';
import '../../features/catalog/presentation/widgets/product_size_selector.dart';
import '../../features/favorites/presentation/favorites_provider.dart';

class ProductDetailPage extends ConsumerWidget {
  const ProductDetailPage({required this.productId, super.key});

  final String productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsync = ref.watch(productByIdProvider(productId));

    return productAsync.when(
      loading: () => const Scaffold(
        appBar: _DetailAppBar(),
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        appBar: const _DetailAppBar(),
        body: const ProductDetailErrorView(
          message: 'We could not load this product. Please try again.',
        ),
      ),
      data: (product) {
        if (product == null) {
          return const Scaffold(
            appBar: _DetailAppBar(),
            body: ProductDetailErrorView(message: 'Product not found.'),
          );
        }
        return _ProductDetailContent(productId: productId);
      },
    );
  }
}

class _ProductDetailContent extends ConsumerWidget {
  const _ProductDetailContent({required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(productByIdProvider(productId)).value!;
    final detailState = ref.watch(productDetailControllerProvider(productId));
    final detailController = ref.read(
      productDetailControllerProvider(productId).notifier,
    );
    final isFavorite = ref.watch(isFavoriteProvider(productId));

    return Scaffold(
      appBar: _DetailAppBar(
        isFavorite: isFavorite,
        onFavoritePressed: () =>
            ref.read(favoritesProvider.notifier).toggle(productId),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProductImageCarousel(product: product),
            const SizedBox(height: 24),
            ProductDetailHeader(product: product),
            if (product.availableSizes.isNotEmpty) ...[
              const SizedBox(height: 28),
              ProductSizeSelector(
                sizes: product.availableSizes,
                selectedSize: detailState.selectedSize,
                onSelected: detailController.selectSize,
              ),
            ],
            if (product.availableColors.isNotEmpty) ...[
              const SizedBox(height: 24),
              ProductColorSelector(
                colors: product.availableColors,
                selectedColorId: detailState.selectedColorId,
                onSelected: detailController.selectColor,
              ),
            ],
            if (detailState.errorMessage != null) ...[
              const SizedBox(height: 18),
              Text(
                detailState.errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ],
        ),
      ),
      bottomNavigationBar: ProductDetailBottomBar(
        enabled: product.isAvailable,
        isLoading: detailState.isAdding,
        onPressed: () {
          if (detailController.addToBag(isAvailable: product.isAvailable)) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Added to bag')));
          }
        },
      ),
    );
  }
}

class _DetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _DetailAppBar({this.isFavorite = false, this.onFavoritePressed});

  final bool isFavorite;
  final VoidCallback? onFavoritePressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Product details'),
      actions: onFavoritePressed == null
          ? null
          : [
              IconButton(
                tooltip: isFavorite
                    ? 'Remove from favorites'
                    : 'Add to favorites',
                onPressed: onFavoritePressed,
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : null,
                ),
              ),
            ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
