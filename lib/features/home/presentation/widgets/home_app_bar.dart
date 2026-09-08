import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    required this.cartItemCount,
    required this.onSearchPressed,
    required this.onFavoritesPressed,
    required this.onCartPressed,
    super.key,
  });

  final int cartItemCount;
  final VoidCallback onSearchPressed;
  final VoidCallback onFavoritesPressed;
  final VoidCallback onCartPressed;

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: onSearchPressed,
        tooltip: 'Search',
        icon: const Icon(Icons.search),
      ),
      actions: [
        IconButton(
          onPressed: onFavoritesPressed,
          tooltip: 'Favorites',
          icon: const Icon(Icons.favorite_border),
        ),
        _CartAction(itemCount: cartItemCount, onPressed: onCartPressed),
        const SizedBox(width: 8),
      ],
    );
  }
}

class _CartAction extends StatelessWidget {
  const _CartAction({required this.itemCount, required this.onPressed});

  final int itemCount;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final label = itemCount == 0 ? 'Cart' : 'Cart, $itemCount items';
    return Semantics(
      button: true,
      label: label,
      child: IconButton(
        onPressed: onPressed,
        tooltip: label,
        icon: Badge(
          isLabelVisible: itemCount > 0,
          label: Text(itemCount > 99 ? '99+' : '$itemCount'),
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.shopping_bag_outlined),
        ),
      ),
    );
  }
}
