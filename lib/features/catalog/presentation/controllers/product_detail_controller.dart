import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../features/cart/presentation/cart_provider.dart';
import '../catalog_providers.dart';
import 'product_detail_state.dart';

class ProductDetailController extends Notifier<ProductDetailState> {
  ProductDetailController(this.productId);

  final String productId;

  @override
  ProductDetailState build() {
    final product = ref.watch(productByIdProvider(productId)).value;
    if (product == null) return const ProductDetailState();

    final defaultSize = product.availableSizes.contains('S')
        ? 'S'
        : product.availableSizes.firstOrNull;
    final defaultColor = product.availableColors.firstOrNull?.id;
    return ProductDetailState(
      selectedSize: defaultSize,
      selectedColorId: defaultColor,
    );
  }

  void selectSize(String size) {
    state = state.copyWith(selectedSize: size, clearError: true);
  }

  void selectColor(String colorId) {
    state = state.copyWith(selectedColorId: colorId, clearError: true);
  }

  bool validate({required bool isAvailable}) {
    if (!state.canAdd(isAvailable: isAvailable)) {
      state = state.copyWith(
        errorMessage: 'Select a size and color to continue.',
      );
      return false;
    }
    return true;
  }

  bool addToBag({required bool isAvailable}) {
    if (state.isAdding || !validate(isAvailable: isAvailable)) return false;
    state = state.copyWith(isAdding: true, clearError: true);
    ref
        .read(cartProvider.notifier)
        .add(productId, size: state.selectedSize, color: state.selectedColorId);
    state = state.copyWith(isAdding: false);
    return true;
  }
}
