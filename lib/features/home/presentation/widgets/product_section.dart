import 'package:flutter/material.dart';

import '../../domain/entities/product_section.dart';
import 'product_card.dart';

class ProductSectionWidget extends StatelessWidget {
  const ProductSectionWidget({
    required this.section,
    required this.onProductPressed,
    required this.onSeeMorePressed,
    super.key,
  });

  final ProductSection section;
  final ValueChanged<String> onProductPressed;
  final ValueChanged<String> onSeeMorePressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  section.title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                ),
              ),
              TextButton(
                onPressed: () => onSeeMorePressed(section.id),
                child: const Text('See more'),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 224,
          child: ListView.separated(
            key: PageStorageKey<String>('section-${section.id}'),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: section.products.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final product = section.products[index];
              return ProductCard(
                key: ValueKey(product.id),
                product: product,
                onPressed: () => onProductPressed(product.id),
              );
            },
          ),
        ),
      ],
    );
  }
}
