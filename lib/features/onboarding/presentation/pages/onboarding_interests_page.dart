import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../controllers/onboarding_providers.dart';
import '../controllers/onboarding_state.dart';
import '../widgets/onboarding_app_bar.dart';
import '../widgets/onboarding_interest_tile.dart';
import '../widgets/onboarding_linear_progress.dart';
import '../widgets/onboarding_next_button.dart';
import '../widgets/onboarding_page_layout.dart';

class OnboardingInterestsPage extends ConsumerWidget {
  const OnboardingInterestsPage({super.key});

  void _goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.goNamed(RouteNames.onboardingIntro);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<OnboardingState>(onboardingControllerProvider, (previous, next) {
      if (next.process == OnboardingProcess.failure &&
          next.errorMessage != previous?.errorMessage &&
          context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unable to save your interests.')),
        );
      }
    });
    final state = ref.watch(onboardingControllerProvider);
    final controller = ref.read(onboardingControllerProvider.notifier);

    return OnboardingPageLayout(
      header: Column(
        children: [
          OnboardingAppBar(onBack: () => _goBack(context)),
          const OnboardingLinearProgress(value: 1),
          const SizedBox(height: 20),
        ],
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Personalise your experience',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Choose your interests.',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: const Color(0xFF697586)),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(bottom: 8),
              itemCount: state.availableInterests.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final interest = state.availableInterests[index];
                return OnboardingInterestTile(
                  label: interest.name,
                  selected: state.isSelected(interest.id),
                  onTap: () => controller.toggleInterest(interest.id),
                );
              },
            ),
          ),
        ],
      ),
      bottomAction: OnboardingNextButton(
        label: 'Finish',
        enabled: state.canContinue,
        isLoading: state.process == OnboardingProcess.saving,
        onPressed: () async {
          final completed = await controller.complete();
          if (completed && context.mounted) {
            context.goNamed(RouteNames.home);
          }
        },
      ),
    );
  }
}
