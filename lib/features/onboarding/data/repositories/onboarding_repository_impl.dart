import '../../domain/entities/onboarding_preferences.dart';
import '../../domain/repositories/onboarding_repository.dart';
import '../datasources/onboarding_local_datasource.dart';
import '../models/onboarding_preferences_model.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  const OnboardingRepositoryImpl(this._datasource);

  final OnboardingLocalDatasource _datasource;

  @override
  Future<void> complete(OnboardingPreferences preferences) {
    final model = OnboardingPreferencesModel.fromEntity(preferences);
    return _datasource.saveCompleted(model.selectedInterestIds);
  }
}
