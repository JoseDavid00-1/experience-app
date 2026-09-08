import 'package:flutter/material.dart';

class OnboardingAppBar extends StatelessWidget {
  const OnboardingAppBar({required this.onBack, super.key});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: IconButton(
        onPressed: onBack,
        tooltip: 'Back',
        icon: const Icon(Icons.arrow_back),
      ),
    );
  }
}
