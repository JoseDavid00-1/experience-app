import '../../domain/entities/interest.dart';

enum OnboardingProcess { initial, saving, completed, failure }

class OnboardingState {
  OnboardingState({
    required List<Interest> availableInterests,
    required Set<String> selectedInterestIds,
    this.process = OnboardingProcess.initial,
    this.errorMessage,
  }) : availableInterests = List.unmodifiable(availableInterests),
       selectedInterestIds = Set.unmodifiable(selectedInterestIds);

  factory OnboardingState.initial() {
    return OnboardingState(
      availableInterests: <Interest>[],
      selectedInterestIds: <String>{},
    );
  }

  final List<Interest> availableInterests;
  final Set<String> selectedInterestIds;
  final OnboardingProcess process;
  final String? errorMessage;

  bool isSelected(String id) => selectedInterestIds.contains(id);
  bool get canContinue => selectedInterestIds.isNotEmpty;

  OnboardingState copyWith({
    List<Interest>? availableInterests,
    Set<String>? selectedInterestIds,
    OnboardingProcess? process,
    String? errorMessage,
    bool clearError = false,
  }) {
    return OnboardingState(
      availableInterests: availableInterests ?? this.availableInterests,
      selectedInterestIds: selectedInterestIds ?? this.selectedInterestIds,
      process: process ?? this.process,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
