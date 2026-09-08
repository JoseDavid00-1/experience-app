import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class ProductSizeSelector extends StatelessWidget {
  const ProductSizeSelector({
    required this.sizes,
    required this.selectedSize,
    required this.onSelected,
    super.key,
  });

  final List<String> sizes;
  final String? selectedSize;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return _SelectorGroup(
      title: 'Size',
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: sizes
            .map((size) {
              final selected = size == selectedSize;
              return Semantics(
                button: true,
                selected: selected,
                label: 'Size $size${selected ? ', selected' : ''}',
                child: ChoiceChip(
                  label: Text(size),
                  selected: selected,
                  onSelected: (_) => onSelected(size),
                  selectedColor: AppColors.primary,
                  labelStyle: TextStyle(
                    color: selected ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              );
            })
            .toList(growable: false),
      ),
    );
  }
}

class _SelectorGroup extends StatelessWidget {
  const _SelectorGroup({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
        const SizedBox(height: 10),
        child,
      ],
    );
  }
}
