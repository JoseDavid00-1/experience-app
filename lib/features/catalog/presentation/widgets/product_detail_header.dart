import 'package:flutter/material.dart';

import '../../../../core/formatters/currency_formatter.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/product.dart';

class ProductDetailHeader extends StatelessWidget {
  const ProductDetailHeader({required this.product, super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                product.name,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Text(
              formatCurrency(product.priceInCents, product.currencyCode),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        if (product.description.isNotEmpty) ...[
          const SizedBox(height: 10),
          Text(
            product.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.secondaryText,
              height: 1.4,
            ),
          ),
        ],
      ],
    );
  }
}
