import 'package:shared_preferences/shared_preferences.dart';

class OnboardingLocalDatasource {
  const OnboardingLocalDatasource(this._preferences);

  static const completedKey = 'onboarding_completed';
  static const selectedInterestsKey = 'onboarding_selected_interests';

  final SharedPreferencesAsync _preferences;

  Future<void> saveCompleted(Set<String> selectedInterestIds) async {
    await _preferences.setBool(completedKey, true);
    await _preferences.setStringList(
      selectedInterestsKey,
      selectedInterestIds.toList(growable: false),
    );
  }
}
