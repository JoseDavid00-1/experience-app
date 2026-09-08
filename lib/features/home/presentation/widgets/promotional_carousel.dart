import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/promotional_banner.dart';

class PromotionalCarousel extends StatefulWidget {
  const PromotionalCarousel({required this.banners, super.key});

  final List<PromotionalBanner> banners;

  @override
  State<PromotionalCarousel> createState() => _PromotionalCarouselState();
}

class _PromotionalCarouselState extends State<PromotionalCarousel> {
  late final PageController _pageController;
  int _activeIndex = 0;

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
    if (widget.banners.isEmpty) return const SizedBox.shrink();
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 2.05,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.banners.length,
              onPageChanged: (index) => setState(() => _activeIndex = index),
              itemBuilder: (context, index) {
                final banner = widget.banners[index];
                return Semantics(
                  label:
                      'Promotional image ${index + 1} of ${widget.banners.length}',
                  image: true,
                  child: Container(
                    color: AppColors.illustrationBackground,
                    alignment: Alignment.center,
                    child: banner.imageAsset == null
                        ? const Icon(
                            Icons.image_outlined,
                            size: 56,
                            color: AppColors.primary,
                          )
                        : Image.asset(banner.imageAsset!, fit: BoxFit.cover),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
        Semantics(
          container: true,
          label:
              'Carousel page ${_activeIndex + 1} of ${widget.banners.length}',
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(widget.banners.length, (index) {
              return AnimatedContainer(
                key: ValueKey<String>(
                  'carousel-dot-$index-${index == _activeIndex ? 'active' : 'inactive'}',
                ),
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
