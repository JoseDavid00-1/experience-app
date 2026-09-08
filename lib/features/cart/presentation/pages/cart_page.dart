import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../core/formatters/currency_formatter.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/cart_line.dart';
import '../cart_provider.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lines = ref.watch(cartLinesProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Your bag')),
      body: lines.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            _CartErrorView(onRetry: () => ref.invalidate(cartLinesProvider)),
        data: (items) {
          if (items.isEmpty) return const _CartEmptyView();
          return _CartContent(items: items);
        },
      ),
    );
  }
}

class _CartContent extends ConsumerWidget {
  const _CartContent({required this.items});

  final List<CartLine> items;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final total = ref.watch(cartTotalProvider);
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) => _CartItemTile(line: items[index]),
          ),
        ),
        SafeArea(
          top: false,
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                    Text(
                      formatCurrency(total, 'EUR'),
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () =>
                      context.pushNamed(RouteNames.checkoutShipping),
                  child: const Text('Checkout'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CartItemTile extends ConsumerWidget {
  const _CartItemTile({required this.line});

  final CartLine line;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(cartProvider.notifier);
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 82,
              height: 94,
              decoration: BoxDecoration(
                color: AppColors.illustrationBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.image_outlined, color: AppColors.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    line.product.name,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    line.variantLabel,
                    style: const TextStyle(color: AppColors.secondaryText),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    formatCurrency(
                      line.product.priceInCents,
                      line.product.currencyCode,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _QuantityButton(
                        icon: Icons.remove,
                        label: 'Decrease ${line.product.name}',
                        onPressed: () => controller.decrease(line.key),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text('${line.quantity}'),
                      ),
                      _QuantityButton(
                        icon: Icons.add,
                        label: 'Increase ${line.product.name}',
                        onPressed: () => controller.increase(line.key),
                      ),
                      const Spacer(),
                      IconButton(
                        tooltip: 'Remove ${line.product.name}',
                        onPressed: () => controller.remove(line.key),
                        icon: const Icon(Icons.delete_outline),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  const _QuantityButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: label,
      onPressed: onPressed,
      visualDensity: VisualDensity.compact,
      icon: Icon(icon, size: 18),
    );
  }
}

class _CartEmptyView extends StatelessWidget {
  const _CartEmptyView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Text('Your bag is empty.'),
      ),
    );
  }
}

class _CartErrorView extends StatelessWidget {
  const _CartErrorView({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('We could not load your bag.'),
          const SizedBox(height: 12),
          OutlinedButton(onPressed: onRetry, child: const Text('Try again')),
        ],
      ),
    );
  }
}
