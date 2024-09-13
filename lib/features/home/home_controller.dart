import 'package:daksh_ptype/features/api_service.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import 'get_category_model.dart';

class HomeController extends GetxController{
  @override
  Future<void> onReady() async {
    // TODO: implement onReady
    super.onReady();
    categoryList.value = await fetchCategory();
    print(categoryList.first.name);
  }
  RxList<GetCategoryMasterModel> categoryList = <GetCategoryMasterModel>[].obs;
}
