import 'package:get/get.dart';

import '../api_service.dart';

class CartCountController extends GetxController {
  RxInt cartCount = getCartProductIds().length.obs;

  updateCartCount() {
    cartCount.value = getCartProductIds().length;
  }
}
