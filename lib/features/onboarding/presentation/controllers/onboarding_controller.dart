import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/interest.dart';
import 'onboarding_providers.dart';
import 'onboarding_state.dart';

class OnboardingController extends Notifier<OnboardingState> {
  static const _interests = <Interest>[
    Interest(id: 'ui', name: 'User Interface'),
    Interest(id: 'ux', name: 'User Experience'),
    Interest(id: 'research', name: 'User Research'),
    Interest(id: 'writing', name: 'UX Writing'),
    Interest(id: 'testing', name: 'User Testing'),
    Interest(id: 'service', name: 'Service Design'),
    Interest(id: 'strategy', name: 'Strategy'),
    Interest(id: 'systems', name: 'Design Systems'),
  ];

  @override
  OnboardingState build() {
    return OnboardingState.initial().copyWith(availableInterests: _interests);
  }

  void toggleInterest(String interestId) {
    if (state.process == OnboardingProcess.saving) return;
    final nextSelection = Set<String>.from(state.selectedInterestIds);
    if (!nextSelection.add(interestId)) {
      nextSelection.remove(interestId);
    }
    state = state.copyWith(
      selectedInterestIds: Set.unmodifiable(nextSelection),
      clearError: true,
    );
  }

  Future<bool> complete() async {
    if (!state.canContinue || state.process == OnboardingProcess.saving) {
      return false;
    }
    state = state.copyWith(process: OnboardingProcess.saving, clearError: true);
    try {
      await ref.read(completeOnboardingProvider)(state.selectedInterestIds);
      state = state.copyWith(process: OnboardingProcess.completed);
      return true;
    } on Object catch (error) {
      state = state.copyWith(
        process: OnboardingProcess.failure,
        errorMessage: error.toString(),
      );
      return false;
    }
  }

  void reset() {
    state = OnboardingState.initial().copyWith(availableInterests: _interests);
  }
}
