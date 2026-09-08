import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/product.dart';

class ProductImageCarousel extends StatefulWidget {
  const ProductImageCarousel({required this.product, super.key});

  final Product product;

  @override
  State<ProductImageCarousel> createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends State<ProductImageCarousel> {
  late final PageController _pageController;
  int _activeIndex = 0;

  int get _imageCount => widget.product.imageAssets.isEmpty
      ? 3
      : widget.product.imageAssets.length;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 0.92,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: PageView.builder(
              controller: _pageController,
              itemCount: _imageCount,
              onPageChanged: (index) => setState(() => _activeIndex = index),
              itemBuilder: (context, index) {
                return Semantics(
                  image: true,
                  label:
                      '${widget.product.name} image ${index + 1} of $_imageCount',
                  child: Container(
                    color: AppColors.illustrationBackground,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.image_outlined,
                      size: 76,
                      color: AppColors.primary,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 12),
        Semantics(
          container: true,
          label: 'Product image ${_activeIndex + 1} of $_imageCount',
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(_imageCount, (index) {
              return AnimatedContainer(
                key: ValueKey('detail-dot-$index'),
                duration: const Duration(milliseconds: 180),
                width: index == _activeIndex ? 18 : 7,
                height: 7,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  color: index == _activeIndex
                      ? AppColors.primary
                      : AppColors.border,
                  borderRadius: BorderRadius.circular(8),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
