import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/product_color.dart';

class ProductColorSelector extends StatelessWidget {
  const ProductColorSelector({
    required this.colors,
    required this.selectedColorId,
    required this.onSelected,
    super.key,
  });

  final List<ProductColor> colors;
  final String? selectedColorId;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Color', style: TextStyle(fontWeight: FontWeight.w800)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 12,
          children: colors
              .map((color) {
                final selected = color.id == selectedColorId;
                return Semantics(
                  button: true,
                  selected: selected,
                  label: 'Color ${color.name}${selected ? ', selected' : ''}',
                  child: Tooltip(
                    message: color.name,
                    child: InkWell(
                      onTap: () => onSelected(color.id),
                      customBorder: const CircleBorder(),
                      child: Container(
                        width: 44,
                        height: 44,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: selected
                                ? AppColors.primary
                                : AppColors.border,
                            width: selected ? 3 : 1,
                          ),
                        ),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(color.colorValue),
                          ),
                          child: selected
                              ? const Icon(
                                  Icons.check,
                                  size: 18,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                      ),
                    ),
                  ),
                );
              })
              .toList(growable: false),
        ),
      ],
    );
  }
}
