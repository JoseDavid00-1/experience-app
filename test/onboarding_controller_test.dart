import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:experience_app/features/onboarding/domain/entities/onboarding_preferences.dart';
import 'package:experience_app/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:experience_app/features/onboarding/domain/usecases/complete_onboarding.dart';
import 'package:experience_app/features/onboarding/presentation/controllers/onboarding_providers.dart';
import 'package:experience_app/features/onboarding/presentation/controllers/onboarding_state.dart';

void main() {
  test('selecting an interest creates a new immutable set', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final controller = container.read(onboardingControllerProvider.notifier);

    expect(controller.state.selectedInterestIds, isEmpty);
    expect(controller.state.canContinue, isFalse);

    controller.toggleInterest('ui');
    final selected = controller.state.selectedInterestIds;

    expect(selected, contains('ui'));
    expect(selected, isA<Set<String>>());
    expect(controller.state.canContinue, isTrue);
    expect(() => selected.add('ux'), throwsUnsupportedError);

    controller.toggleInterest('ui');
    expect(controller.state.selectedInterestIds, isEmpty);
  });

  test(
    'complete reports completed and passes a snapshot to the repository',
    () async {
      final repository = RecordingRepository();
      final container = ProviderContainer(
        overrides: [
          completeOnboardingProvider.overrideWithValue(
            CompleteOnboarding(repository),
          ),
        ],
      );
      addTearDown(container.dispose);
      final controller = container.read(onboardingControllerProvider.notifier);

      controller.toggleInterest('ui');
      final result = await controller.complete();

      expect(result, isTrue);
      expect(controller.state.process, OnboardingProcess.completed);
      expect(repository.preferences?.selectedInterestIds, {'ui'});
    },
  );

  test('complete reports failure when persistence fails', () async {
    final container = ProviderContainer(
      overrides: [
        completeOnboardingProvider.overrideWithValue(
          CompleteOnboarding(FailingRepository()),
        ),
      ],
    );
    addTearDown(container.dispose);
    final controller = container.read(onboardingControllerProvider.notifier);

    controller.toggleInterest('ui');
    final result = await controller.complete();

    expect(result, isFalse);
    expect(controller.state.process, OnboardingProcess.failure);
    expect(controller.state.errorMessage, isNotEmpty);
  });

  test('complete does not persist without a selection', () async {
    final repository = RecordingRepository();
    final container = ProviderContainer(
      overrides: [
        completeOnboardingProvider.overrideWithValue(
          CompleteOnboarding(repository),
        ),
      ],
    );
    addTearDown(container.dispose);
    final controller = container.read(onboardingControllerProvider.notifier);

    expect(await controller.complete(), isFalse);
    expect(controller.state.process, OnboardingProcess.initial);
    expect(repository.preferences, isNull);
  });
}

class RecordingRepository implements OnboardingRepository {
  OnboardingPreferences? preferences;

  @override
  Future<void> complete(OnboardingPreferences preferences) async {
    this.preferences = preferences;
  }
}

class FailingRepository implements OnboardingRepository {
  @override
  Future<void> complete(OnboardingPreferences preferences) {
    throw StateError('test persistence failure');
  }
}
