import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'product_detail_controller.dart';
import 'product_detail_state.dart';

final productDetailControllerProvider =
    NotifierProvider.family<
      ProductDetailController,
      ProductDetailState,
      String
    >((productId) => ProductDetailController(productId));
