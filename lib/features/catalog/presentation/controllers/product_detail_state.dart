class ProductDetailState {
  const ProductDetailState({
    this.selectedSize,
    this.selectedColorId,
    this.isAdding = false,
    this.errorMessage,
  });

  final String? selectedSize;
  final String? selectedColorId;
  final bool isAdding;
  final String? errorMessage;

  bool canAdd({required bool isAvailable}) {
    return isAvailable && selectedSize != null && selectedColorId != null;
  }

  ProductDetailState copyWith({
    String? selectedSize,
    String? selectedColorId,
    bool? isAdding,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ProductDetailState(
      selectedSize: selectedSize ?? this.selectedSize,
      selectedColorId: selectedColorId ?? this.selectedColorId,
      isAdding: isAdding ?? this.isAdding,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
