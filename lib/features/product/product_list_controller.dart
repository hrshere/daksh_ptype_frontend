import 'package:daksh_ptype/features/api_service.dart';
import 'package:daksh_ptype/features/common/get_material_model.dart';
import 'package:daksh_ptype/features/common/get_shape_model.dart';
import 'package:daksh_ptype/features/product/product_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../home/get_category_model.dart';

class ProductListController extends GetxController {
  final GetStorage storage = GetStorage();
  @override
  Future<void> onReady() async {
    // TODO: implement onReady
    // print('check arguments ');
    super.onReady();
    print('check arguments berf');
    // if (Get.arguments['category'] == null) {
    //   category.value = 1;
    // } else {
    //   category.value = Get.arguments['category'];
    // }

    print('check arguments');
    if (Get.parameters != null && Get.parameters['id'] != null) {
      category.value = int.parse(Get.parameters['id'] ?? '3');
      // storage.write('savedCategory', category.value);  // Save category value locally
    }
    // else {
    //   category.value = storage.read('savedCategory') ?? 0;  // Load saved category or default to 0
    // }
    categoryList.value = await fetchCategory();
    materialList.value = await fetchMaterial();
    shapeList.value = await fetchShape();
    productsList.value =
        await fetchProducts(searchController.text, shape.value, rating.value, material.value, category.value);
  }

  // Reactive properties for selected indices
  var selectedCategoryIndex = (-1).obs;
  var selectedMaterialIndex = (-1).obs;
  var selectedShapeIndex = (-1).obs;

  RxList<GetProductsModel> productsList = <GetProductsModel>[].obs;
  RxString name = ''.obs;
  RxInt shape = 0.obs;
  RxInt material = 0.obs;
  RxInt category = 0.obs;
  RxInt rating = 0.obs;
  final searchController = TextEditingController();
  RxList<GetCategoryMasterModel> categoryList = <GetCategoryMasterModel>[].obs;
  RxList<GetMaterialsModel> materialList = <GetMaterialsModel>[].obs;
  RxList<GetShapesModel> shapeList = <GetShapesModel>[].obs;
}
