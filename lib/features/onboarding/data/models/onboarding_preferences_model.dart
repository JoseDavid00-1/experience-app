import '../../domain/entities/onboarding_preferences.dart';

class OnboardingPreferencesModel {
  const OnboardingPreferencesModel({required this.selectedInterestIds});

  factory OnboardingPreferencesModel.fromEntity(OnboardingPreferences entity) {
    return OnboardingPreferencesModel(
      selectedInterestIds: entity.selectedInterestIds,
    );
  }

  final Set<String> selectedInterestIds;
}
