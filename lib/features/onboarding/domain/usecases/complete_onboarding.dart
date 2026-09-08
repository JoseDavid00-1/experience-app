import '../entities/onboarding_preferences.dart';
import '../repositories/onboarding_repository.dart';

class CompleteOnboarding {
  const CompleteOnboarding(this._repository);

  final OnboardingRepository _repository;

  Future<void> call(Set<String> selectedInterestIds) {
    if (selectedInterestIds.isEmpty) {
      throw const CompleteOnboardingException();
    }
    return _repository.complete(
      OnboardingPreferences(
        selectedInterestIds: Set.unmodifiable(selectedInterestIds),
      ),
    );
  }
}

class CompleteOnboardingException implements Exception {
  const CompleteOnboardingException();
}
