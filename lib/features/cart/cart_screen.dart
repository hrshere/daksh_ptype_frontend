
import 'package:daksh_ptype/features/api_service.dart';
import 'package:daksh_ptype/features/cart/cart_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../page_routes/page_route_constant.dart';
import '../../regex_validators.dart';
import '../common/cart_count_controller.dart';
import 'orders_model.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  void _launchURL() async {
    const url = 'http:///web/stripe/stripe_webview.html';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }



  final CartCountController _cartCountController = Get.find();

  final CartController _cartController = Get.put(CartController());

  GlobalKey<FormState> submitKey = GlobalKey<FormState>(debugLabel: 'c');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Get.toNamed(PageRouteConstant.cart);
                },
              ),
              Positioned(
                right: 2,
                top: 2,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  child: Obx(
                    () => Text(
                      '${_cartCountController.cartCount.value}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Obx(
        () => Form(
          key: submitKey,
          child: Column(
            children: [
              SizedBox(
                height: 330,
                child: _cartController.productsList.isEmpty
                    ? Center(child: Text('Your Cart Is Empty!'))
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _cartController.productsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          var product = _cartController.productsList[index];
                          var productId = product.id!;
                          // WidgetsBinding.instance.addPostFrameCallback((_) {
                          //   if (!_cartController.productQuantities.containsKey(productId)) {
                          //     _cartController.setQuantity(productId, product.minimumQuantity!);
                          //   }
                          // });
                          return GestureDetector(
                            onTap: () => Get.toNamed(PageRouteConstant.productDetails, arguments: {'id': productId}),
                            child: Card(
                              margin: EdgeInsets.all(8.0),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      product.images!.isEmpty
                                          ? SizedBox(height: 100, width: 60, child: Text('No Image Found'))
                                          : Image.network(
                                              product.images!.first.image.toString(),
                                              height: 100,
                                              width: 60,
                                            ),
                                      Text('Save ${product.discountPercent}%'),
                                      Row(
                                        children: [
                                          Text(
                                            '\u{20B9}${product.price.toString()}',
                                            style: const TextStyle(
                                                color: Colors.grey, decoration: TextDecoration.lineThrough),
                                          ),
                                        ],
                                      ),
                                      Text('\u{20B9}${product.discountPrice.toString()}'),
                                      Text(
                                        product.name ?? '',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(product.materialName ?? ''),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(4),
                                            child: GestureDetector(
                                              onTap: () {
                                                _cartController.decreaseQuantity(productId);
                                              },
                                              child: Container(
                                                height: kIsWeb ? 35 : 50,
                                                width: kIsWeb ? 35 : 50,
                                                decoration:
                                                    const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                                                child: const Center(child: Icon(Icons.remove)),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 8),
                                            child: Obx(
                                              () => Text(
                                                _cartController.productQuantities[productId]?.toString() ?? '0',
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(4),
                                            child: GestureDetector(
                                              onTap: () {
                                                _cartController.increaseQuantity(productId);
                                              },
                                              child: Container(
                                                height: kIsWeb ? 35 : 50,
                                                width: kIsWeb ? 35 : 50,
                                                decoration:
                                                    const BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                                                child: const Center(
                                                    child: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                )),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          _cartController.removeFromCarts(productId);
                                        },
                                        icon: Icon(Icons.delete),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
              Obx(
                () => _cartController.productsList.isEmpty
                    ? SizedBox()
                    : Column(
                        children: [
                          Text('Total Items: ${_cartController.totalQuantity}'),
                          Text('Total Price: \u{20B9}${_cartController.totalPrice.toStringAsFixed(2)}'),
                          TextFormField(
                            validator: Validators.isTouchedEmailValidator,
                            controller: _cartController.emailController,
                            decoration: InputDecoration(hintText: 'Enter Email to continue'),
                          ),
                          SizedBox(height: 10,),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.purple,
                                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                                  textStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                              onPressed: (){
                                // createPaymentIntentApiService(300);
                                _cartController.makePayment(_cartController.totalPrice.toInt());
                              },
                              // onPressed: () async {
                              //   if (submitKey.currentState!.validate()) {
                              //     List<OrderProducts> orderProductsList =
                              //         _cartController.productQuantities.entries.map((entry) {
                              //       return OrderProducts(
                              //         product: entry.key,
                              //         quantity: entry.value,
                              //       );
                              //     }).toList();
                              //     bool success = await placeOrderApiService(_cartController.emailController.text,
                              //         orderProductsList, _cartController.totalQuantity, _cartController.totalPrice);
                              //     if (success) {
                              //       Get.defaultDialog(
                              //           title: 'Success',
                              //           content: Text('Order Placed SuccessFully!'),
                              //           confirm: TextButton(
                              //               onPressed: () {
                              //                 Get.back();
                              //                 logger.i('ok button pressed');
                              //                 _cartController.removeAllFromCarts();
                              //               },
                              //               child: Text('Ok')),
                              //           onConfirm: () {
                              //             // Get.back();
                              //             // logger.i('ok button pressed');
                              //           });
                              //     }
                              //   }
                              // },
                              child: Text(
                                'Place Order ',
                                style: TextStyle(color: Colors.white),
                              ))
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
