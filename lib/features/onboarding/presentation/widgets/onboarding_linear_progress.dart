import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class OnboardingLinearProgress extends StatelessWidget {
  const OnboardingLinearProgress({required this.value, super.key});

  final double value;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Onboarding progress ${(value * 100).round()} percent',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: LinearProgressIndicator(
          value: value,
          minHeight: 5,
          backgroundColor: AppColors.border,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
