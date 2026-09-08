import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../core/theme/app_theme.dart';
import '../widgets/onboarding_dots_indicator.dart';
import '../widgets/onboarding_next_button.dart';
import '../widgets/onboarding_page_layout.dart';

class OnboardingIntroPage extends StatelessWidget {
  const OnboardingIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingPageLayout(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 12, bottom: 24),
              decoration: BoxDecoration(
                color: AppColors.illustrationBackground,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Center(
                child: Semantics(
                  label: 'Onboarding illustration placeholder',
                  image: true,
                  child: Icon(
                    Icons.image_outlined,
                    size: 72,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ),
          const Center(child: OnboardingDotsIndicator(activeIndex: 0)),
          const SizedBox(height: 24),
          Text(
            'Create a prototype in just a few minutes',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Enjoy these pre-made components and worry only about creating the '
            'best product ever.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.secondaryText,
              height: 1.45,
            ),
          ),
        ],
      ),
      bottomAction: OnboardingNextButton(
        label: 'Next',
        onPressed: () => context.pushNamed(RouteNames.onboardingInterests),
      ),
    );
  }
}
