import 'package:daksh_ptype/features/api_service.dart';
import 'package:daksh_ptype/features/product_details/product_details_controller.dart';
import 'package:daksh_ptype/page_routes/page_route_constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../common/cart_count_controller.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({Key? key}) : super(key: key);
  final CartCountController _cartCountController = Get.find();

  final ProductDetailsController _productDetailsController = Get.put(ProductDetailsController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text('Product Details'),
          actions: [Stack(
              children: [IconButton(
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
                    child: Text(
                      '${_cartCountController.cartCount.value}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ]
          ),],
        ),
        body: SingleChildScrollView(
          child: Card(
            elevation: 0,
            child: Column(
              children: [
                Row(
                  children: [
                    // SizedBox(
                    //   height: 600,
                    //   width: 100,
                    //   child: ListView.builder(itemCount:_productDetailsController.productDetails.value.images?.length,itemBuilder: (context,int index){
                    //     return Container(
                    //       child: Image.network(_productDetailsController.productDetails.value.images![index].image.toString()),
                    //     );
                    //   }),
                    // ),
                    _productDetailsController.productDetails.value.images!.isEmpty
                        ? SizedBox(height: 300, width: 300, child: Center(child: const Text('no image')))
                        : Image.network(
                            _productDetailsController.productDetails.value.images!.first.image.toString(),
                            height: 300,
                            width: 300,
                          ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_productDetailsController.productDetails.value.name ?? ""),
                          RatingBarIndicator(
                            rating: _productDetailsController.productDetails.value.ratingValue!.toDouble(),
                            // initialRating: 4,
                            // direction: _isVertical ? Axis.vertical : Axis.horizontal,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, index) {
                              switch (index) {
                                case 0:
                                  return Icon(
                                    Icons.sentiment_very_dissatisfied,
                                    color: Colors.red,
                                  );
                                case 1:
                                  return Icon(
                                    Icons.sentiment_dissatisfied,
                                    color: Colors.redAccent,
                                  );
                                case 2:
                                  return Icon(
                                    Icons.sentiment_neutral,
                                    color: Colors.amber,
                                  );
                                case 3:
                                  return Icon(
                                    Icons.sentiment_satisfied,
                                    color: Colors.lightGreen,
                                  );
                                case 4:
                                  return Icon(
                                    Icons.sentiment_very_satisfied,
                                    color: Colors.green,
                                  );
                                default:
                                  return Container();
                              }
                            },
                          ),
                          Row(
                            children: [
                              Chip(
                                label: Text(
                                    'save ${_productDetailsController.productDetails.value.discountPercent.toString()}%' ??
                                        ""),
                                backgroundColor: Colors.redAccent,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                _productDetailsController.productDetails.value.price.toString() ?? "",
                                style: const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                  '${_productDetailsController.productDetails.value.discountPrice.toString()}/per piece' ??
                                      ""),
                            ],
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Size(inch)',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(_productDetailsController.productDetails.value.size.toString() ?? "")
                                ],
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Weight (kg)',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(_productDetailsController.productDetails.value.weight.toString() ?? "")
                                ],
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Shape',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(_productDetailsController.productDetails.value.shapeName ?? "")
                                ],
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Material',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(_productDetailsController.productDetails.value.materialName ?? "")
                                ],
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Min. order quantity',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(_productDetailsController.productDetails.value.minimumQuantity.toString() ?? "")
                                ],
                              ),
                            ],
                          ),
                          Text(
                            'Description:',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Row(
                            children: [
                              Text('Note:'),
                              Text(_productDetailsController.productDetails.value.description?.note ?? ""),
                            ],
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(4),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (_productDetailsController.minQuantity.value > 5) {
                                          _productDetailsController.minQuantity.value--;
                                        }
                                      },
                                      child: Container(
                                        height: kIsWeb ? 35 : 50,
                                        width: kIsWeb ? 35 : 50,
                                        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                                        child: const Center(child: Icon(Icons.remove)),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8),
                                    child: Text(
                                      _productDetailsController.minQuantity.value.toString(),
                                      // style: appPrimaryTheme.textTheme.labelSmall
                                      //     ?.copyWith(color: TextColor.darkBlackHeading),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(4),
                                    child: GestureDetector(
                                      onTap: () {
                                        // if (_productDetailsController.minQuantity.value < 5) {
                                        _productDetailsController.minQuantity.value++;
                                        // }
                                      },
                                      child: Container(
                                        height: kIsWeb ? 35 : 50,
                                        width: kIsWeb ? 35 : 50,
                                        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.green),
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
                              SizedBox(
                                width: 20,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  bool added = addToCart(_productDetailsController.productDetails.value.id ?? 0);
                                  added?_cartCountController.updateCartCount():null;
                                },
                                child: Text(
                                  'Buy Now',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                                    textStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  bool added = addToCart(_productDetailsController.productDetails.value.id ?? 0);
                                  added ? _cartCountController.updateCartCount() : null;
                                },
                                child: Text(
                                  'Add To Cart',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.purple,
                                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                                    textStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),

                // Text(_productDetailsController.productDetails.value.price ?? ""),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
