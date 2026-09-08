class OnboardingPreferences {
  OnboardingPreferences({required Set<String> selectedInterestIds})
    : selectedInterestIds = Set.unmodifiable(selectedInterestIds);

  final Set<String> selectedInterestIds;
}
