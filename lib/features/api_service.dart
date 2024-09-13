import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:daksh_ptype/features/common/get_material_model.dart';
import 'package:daksh_ptype/features/common/get_shape_model.dart';
import 'package:daksh_ptype/features/product/product_list_model.dart';
import 'package:daksh_ptype/network/commom_api_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'cart/orders_model.dart';
import 'home/get_category_model.dart';


var logger = Logger(
  printer: PrettyPrinter(),
);
final GetStorage _storage = GetStorage();
final String _cartKey = 'cart';
fetchShape() async {
  var response = await CommonApiService().fetchShapes();
  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    List<GetShapesModel> shapes = data.map((json) => GetShapesModel.fromJson(json)).toList();
    return shapes;
  } else {
    throw Exception('Failed to load categories');
  }
}fetchMaterial() async {
  var response = await CommonApiService().fetchMaterials();
  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    List<GetMaterialsModel> materials = data.map((json) => GetMaterialsModel.fromJson(json)).toList();
    return materials;
  } else {
    throw Exception('Failed to load categories');
  }
}
fetchCategory() async {
  var response = await CommonApiService().fetchCategories();
  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    List<GetCategoryMasterModel> categories = data.map((json) => GetCategoryMasterModel.fromJson(json)).toList();
    return categories;
  } else {
    throw Exception('Failed to load categories');
  }
}

fetchProducts(name,shape,rating,material,category) async {
  var response = await CommonApiService().fetchProducts(name,shape,rating,material,category);
  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    List<GetProductsModel> products = data.map((json) => GetProductsModel.fromJson(json)).toList();
    return products;
  } else {
    throw Exception('Failed to load categories');
  }
}

fetchProductsById(id) async {
  var response = await CommonApiService().fetchProductsById(id);
  if (response.statusCode == 200) {
    GetProductsModel data = GetProductsModel.fromJson(json.decode(response.body));

    return data;
  } else {
    throw Exception('Failed to load categories');
  }
}



bool addToCart( int? productId)  {
  logger.w(productId);//outputs 1
  List<int> storedCart = getCartProductIds();
  logger.w(storedCart?.toList());//outputs null instead of list
  if (!storedCart!.contains(productId)) {
    storedCart.add(productId!);
    _storage.write(_cartKey, storedCart.toList());
    print(storedCart.toList());
    logger.e(storedCart.toList());
     Get.snackbar('item added to cart','success',duration :const Duration(seconds: 1));
    return true;
  }
  else{
    Get.snackbar('Item Already Added to cart', 'Alert!');
    return false;
  }
}

bool removeFromCart(int? productId){
  try {
    List<int> storedCart = getCartProductIds();
    storedCart.remove(productId!);
    _storage.write(_cartKey, storedCart.toList());
    logger.w('removed $productId from ${storedCart.toList()}');
    return true;
  }
  catch (e){
    logger.e(e);
    return false;
  }

}

bool removeAllFromCart(){
  try {
    List<int> storedCart = getCartProductIds();
    storedCart.clear();
    _storage.write(_cartKey, storedCart.toList());
    logger.w('removed All Products ${storedCart.toList()}');
    return true;
  }
  catch (e){
    logger.e(e);
    return false;
  }

}

List<int> getCartProductIds() {
  final List<dynamic>? storedCart = _storage.read<List<dynamic>>(_cartKey);
  if (storedCart != null) {
    return storedCart.map((item) => item as int).toList();
  }
  return [];
}

fetchProductsByIds() async {
  List<int> productIds = getCartProductIds();
  logger.w('productIds:$productIds');
  //
  if (productIds.isEmpty) {
    logger.w('got here');
    return <GetProductsModel>[]; // Return an empty list if no product IDs are found
  }


  var response = await CommonApiService().fetchProductsByIds(productIds);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<GetProductsModel> products = data.map((json) => GetProductsModel.fromJson(json)).toList();
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }

Future<bool> placeOrderApiService(email,productQuantityList,totalItem,totalPrice) async {
  OrdersModel order = OrdersModel(
    totalQuantity: totalItem,
    totalPrice: totalPrice,  // Replace with your actual total price calculation
    orderProducts: productQuantityList,
    userEmail: email,
  );
  Map<String, dynamic> requestBody = order.toJson();

  var response = await CommonApiService().placeOrder(requestBody);
  logger.w('placing the order with $email');

  if (response.statusCode == 201) {
    logger.i('successfully placed the order with $email');
    return true;

  } else {
    logger.e('Failed to place the order with $email');

    throw Exception('Failed to load categories');
  }
}

Future<String?> createPaymentIntentApiService(amount) async {
  var response = await CommonApiService().createPaymentIntent({
    "amount": amount
  });
  logger.w('placing the order with $amount dollors');

  if (response.statusCode == 200) {
    logger.i('successfully created payment intent');
    final responseBody = jsonDecode(response.body);
    return responseBody['client_secret'];

  } else {
    logger.e('Failed to create payment intent');

    throw Exception('Failed');
  }
}


