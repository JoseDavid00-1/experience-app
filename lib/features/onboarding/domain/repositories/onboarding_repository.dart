import '../entities/onboarding_preferences.dart';

abstract interface class OnboardingRepository {
  Future<void> complete(OnboardingPreferences preferences);
}
