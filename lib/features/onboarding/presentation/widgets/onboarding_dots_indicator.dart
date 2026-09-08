import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class OnboardingDotsIndicator extends StatelessWidget {
  const OnboardingDotsIndicator({required this.activeIndex, super.key});

  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Onboarding step ${activeIndex + 1} of 2',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(2, (index) {
          return Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index == activeIndex
                  ? AppColors.primary
                  : AppColors.border,
            ),
          );
        }),
      ),
    );
  }
}
