import 'package:daksh_ptype/features/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../common/cart_count_controller.dart';
import '../product/product_list_model.dart';
import 'orders_model.dart';

class CartController extends GetxController {
  final emailController = TextEditingController();
  final CartCountController _cartCountController = Get.find();
  final GetStorage storage = GetStorage();
  var productQuantities = <int, int>{}.obs; // Map to store product IDs and their quantities
  RxInt quantity = 0.obs;

  @override
  Future<void> onReady() async {
    super.onReady();
    await initializeCart();
  }

  Future<void> initializeCart() async {
    productsList.value = await fetchProductsByIds();
    loadQuantities();
    setInitialQuantities();
  }

  void setInitialQuantities() {
    for (var product in productsList) {
      if (!productQuantities.containsKey(product.id)) {
        productQuantities[product.id!] = product.minimumQuantity!;
      }
    }
    saveQuantities();
  }

  RxList<GetProductsModel> productsList = <GetProductsModel>[].obs;

  void updateCartQuantity() {
    quantity.value = quantity.value;
    saveQuantities();
  }

  void setQuantity(int productId, int quantity) {
    productQuantities[productId] = quantity;
    updateCartQuantity();
  }

  void increaseQuantity(int productId) {
    if (productQuantities.containsKey(productId)) {
      productQuantities[productId] = productQuantities[productId]! + 1;
    } else {
      productQuantities[productId] = 1;
    }
    updateCartQuantity();
  }

  void decreaseQuantity(int productId) {
    if (productQuantities.containsKey(productId) && productQuantities[productId]! > 1) {
      productQuantities[productId] = productQuantities[productId]! - 1;
      updateCartQuantity();
    }
  }

  int get totalQuantity => productQuantities.values.fold(0, (sum, quantity) => sum + quantity);

  void removeFromCarts(int productId) {
    bool deleted = removeFromCart(productId);
    if (deleted) {
      productsList.removeWhere((product) => product.id == productId);
      _cartCountController.updateCartCount();
      productQuantities.remove(productId); // to update quantity upon product removal
      saveQuantities();
    }
  }

  void removeAllFromCarts() {
    bool deleted = removeAllFromCart();
    if (deleted) {
      productsList.clear();
      _cartCountController.updateCartCount();
      productQuantities.clear(); // to update quantity upon product removal
      saveQuantities();
    }
  }

  double get totalPrice {
    double total = 0.0;
    for (var product in productsList) {
      if (productQuantities.containsKey(product.id)) {
        total += product.discountPrice! * productQuantities[product.id]!;
      }
    }
    return total;
  }

  void saveQuantities() {
    Map<String, int> quantitiesToSave = productQuantities.map((key, value) => MapEntry(key.toString(), value));
    storage.write('productQuantities', quantitiesToSave);
  }

  void loadQuantities() {
    try {
      Map<String, int> storedQuantities = (storage.read('productQuantities') as Map<String, dynamic>)?.map((key, value) => MapEntry(key, value as int)) ?? {};
      productQuantities.value = storedQuantities.map((key, value) => MapEntry(int.parse(key), value));
    } catch (e) {
      // Handle the error, e.g., by logging it or setting default values
      print("Error loading quantities: $e");
      productQuantities.value = {};
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {

        //Clear paymentIntent variable after successful payment
        // paymentIntent = null;

      })
          .onError((error, stackTrace) {
        throw Exception(error);
      });
    }
    on StripeException catch (e) {
      print('Error is:---> $e');
    }
    catch (e) {
      print('$e');
    }
  }

  Future<void> makePayment(int amount) async {
    try {
      //STEP 1: Create Payment Intent
      String? clientSecret = await createPaymentIntentApiService(amount);

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(

          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: clientSecret, //Gotten from payment intent

              merchantDisplayName: 'Himanshu'))
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet();
    } catch (err) {
      throw Exception(err);
    }
  }
}
