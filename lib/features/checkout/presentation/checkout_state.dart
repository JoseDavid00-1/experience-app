class CheckoutState {
  const CheckoutState({
    this.selectedPaymentMethodId,
    this.billingMatchesShipping = true,
    this.isProcessing = false,
    this.errorMessage,
  });

  final String? selectedPaymentMethodId;
  final bool billingMatchesShipping;
  final bool isProcessing;
  final String? errorMessage;

  CheckoutState copyWith({
    String? selectedPaymentMethodId,
    bool? billingMatchesShipping,
    bool? isProcessing,
    String? errorMessage,
    bool clearError = false,
  }) {
    return CheckoutState(
      selectedPaymentMethodId:
          selectedPaymentMethodId ?? this.selectedPaymentMethodId,
      billingMatchesShipping:
          billingMatchesShipping ?? this.billingMatchesShipping,
      isProcessing: isProcessing ?? this.isProcessing,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
