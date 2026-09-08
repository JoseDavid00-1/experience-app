import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class OnboardingInterestTile extends StatelessWidget {
  const OnboardingInterestTile({
    required this.label,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: '$label${selected ? ', selected' : ''}',
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: selected ? AppColors.selectedBackground : Colors.white,
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.border,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            child: Row(
              children: [
                Expanded(child: Text(label)),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 180),
                  child: selected
                      ? const Icon(
                          Icons.check_circle,
                          key: ValueKey('selected'),
                          color: AppColors.primary,
                        )
                      : const SizedBox(
                          key: ValueKey('unselected'),
                          width: 24,
                          height: 24,
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
