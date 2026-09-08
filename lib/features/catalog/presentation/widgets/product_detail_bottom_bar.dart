import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class ProductDetailBottomBar extends StatelessWidget {
  const ProductDetailBottomBar({
    required this.enabled,
    required this.isLoading,
    required this.onPressed,
    super.key,
  });

  final bool enabled;
  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
        child: Semantics(
          button: true,
          enabled: enabled && !isLoading,
          label: isLoading ? 'Adding to bag' : 'Add to bag',
          child: ElevatedButton(
            onPressed: enabled && !isLoading ? onPressed : null,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(54),
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            child: isLoading
                ? const SizedBox.square(
                    dimension: 22,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Add to bag'),
          ),
        ),
      ),
    );
  }
}
