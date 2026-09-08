import 'package:flutter/material.dart';

class OnboardingNextButton extends StatelessWidget {
  const OnboardingNextButton({
    required this.onPressed,
    required this.label,
    this.isLoading = false,
    this.enabled = true,
    super.key,
  });

  final VoidCallback? onPressed;
  final String label;
  final bool isLoading;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      enabled: enabled && !isLoading,
      label: isLoading ? 'Saving' : label,
      child: ElevatedButton(
        onPressed: enabled && !isLoading ? onPressed : null,
        child: isLoading
            ? const SizedBox.square(
                dimension: 22,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Text(label),
      ),
    );
  }
}
