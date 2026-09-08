import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class CheckoutStepIndicator extends StatelessWidget {
  const CheckoutStepIndicator({required this.currentStep, super.key});

  final int currentStep;

  static const _labels = ['Your bag', 'Shipping', 'Payment'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(_labels.length, (index) {
        final completed = index < currentStep;
        final current = index == currentStep;
        final color = completed || current
            ? AppColors.primary
            : AppColors.secondaryText;
        return Expanded(
          child: Semantics(
            label: '${_labels[index]}${current ? ', current step' : ''}',
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 4,
                        color: index == 0 ? Colors.transparent : color,
                      ),
                    ),
                    CircleAvatar(
                      radius: 13,
                      backgroundColor: color,
                      child: completed
                          ? const Icon(
                              Icons.check,
                              size: 16,
                              color: Colors.white,
                            )
                          : Text(
                              '${index + 1}',
                              style: const TextStyle(color: Colors.white),
                            ),
                    ),
                    Expanded(
                      child: Container(
                        height: 4,
                        color: index == _labels.length - 1
                            ? Colors.transparent
                            : (completed
                                  ? AppColors.primary
                                  : AppColors.border),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  _labels[index],
                  style: TextStyle(
                    color: color,
                    fontWeight: current ? FontWeight.w800 : FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
