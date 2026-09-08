import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/datasources/onboarding_local_datasource.dart';
import '../../data/repositories/onboarding_repository_impl.dart';
import '../../domain/repositories/onboarding_repository.dart';
import '../../domain/usecases/complete_onboarding.dart';
import 'onboarding_controller.dart';
import 'onboarding_state.dart';

final onboardingRepositoryProvider = Provider<OnboardingRepository>((ref) {
  final datasource = OnboardingLocalDatasource(SharedPreferencesAsync());
  return OnboardingRepositoryImpl(datasource);
});

final completeOnboardingProvider = Provider<CompleteOnboarding>((ref) {
  return CompleteOnboarding(ref.watch(onboardingRepositoryProvider));
});

final onboardingControllerProvider =
    NotifierProvider<OnboardingController, OnboardingState>(
      OnboardingController.new,
    );
