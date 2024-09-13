import 'package:daksh_ptype/features/api_service.dart';
import 'package:get/get.dart';

import '../product/product_list_model.dart';

class ProductDetailsController extends GetxController{
  @override
  Future<void> onReady() async {
    // TODO: implement onReady
    super.onReady();
    var id = Get.arguments['id'];
    productDetails.value = await fetchProductsById(id);
    minQuantity.value = productDetails.value.minimumQuantity!;
  }
  Rx<GetProductsModel> productDetails = GetProductsModel().obs;
  RxInt minQuantity = 0.obs;
}