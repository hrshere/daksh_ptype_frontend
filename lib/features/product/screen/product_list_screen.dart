import 'package:daksh_ptype/features/api_service.dart';
import 'package:daksh_ptype/features/product/product_list_controller.dart';
import 'package:daksh_ptype/page_routes/page_route_constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/cart_count_controller.dart';

class ProductListScreen extends StatelessWidget {
  ProductListScreen({Key? key}) : super(key: key);
  final CartCountController _cartCountController = Get.find();
  final ProductListController _productListController = Get.put(ProductListController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text('Products'),
                    IconButton(onPressed: (){_productListController.onReady();}, icon: Icon(Icons.refresh)),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 5,
                      child: TextField(
                        controller: _productListController.searchController,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          border: OutlineInputBorder(),
                          suffixIcon: _productListController.searchController.text.isEmpty?IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              _productListController.onReady();
                            },
                          ):IconButton(onPressed: (){
                            _productListController.searchController.clear();
                            _productListController.onReady();
                          }, icon: Icon(Icons.cancel)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Stack(
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
              ),
            ],
          ),
        ),
        body: Row(
          children: [
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Filters'),
                          TextButton(
                            onPressed: () {
                              // Apply filters logic
                              _productListController.selectedMaterialIndex.isNegative?_productListController.material.value=0:
                              _productListController.material.value = _productListController.materialList[_productListController.selectedMaterialIndex.value].id!;
                              // _productListController.selectedCategoryIndex.isNegative?null:
                              // _productListController.category.value = _productListController.categoryList[_productListController.selectedCategoryIndex.value].id!;
                              _productListController.selectedShapeIndex.isNegative?_productListController.shape.value=0:
                              _productListController.shape.value = _productListController.shapeList[_productListController.selectedShapeIndex.value].id!;
                              _productListController.onReady();
                            },
                            child: Text('Apply'),
                          ),
                        ],
                      ),
                    ),
                    // ExpansionTile(
                    //   title: Text('Categories'),
                    //   children: [
                    //     ListView.builder(
                    //       shrinkWrap: true,
                    //       itemCount: _productListController.categoryList.length,
                    //       itemBuilder: (context, index) {
                    //         return Obx(() {
                    //           return CheckboxListTile(
                    //             contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                    //             visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    //             checkboxShape: RoundedRectangleBorder(side: BorderSide()),
                    //             activeColor: Colors.purple,
                    //             title: Text(
                    //               _productListController.categoryList[index].name ?? "",
                    //               style: TextStyle(fontSize: 10),
                    //             ),
                    //             value: _productListController.selectedCategoryIndex.value == index,
                    //             onChanged: (bool? value) {
                    //               _productListController.selectedCategoryIndex.value = value! ? index : -1;
                    //
                    //             },
                    //           );
                    //         });
                    //       },
                    //     ),
                    //   ],
                    // ),
                    ExpansionTile(
                      title: Text('Materials'),
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: _productListController.materialList.length,
                          itemBuilder: (context, index) {
                            return Obx(() {
                              return CheckboxListTile(
                                contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                                visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                                checkboxShape: RoundedRectangleBorder(side: BorderSide()),
                                activeColor: Colors.purple,
                                title: Text(
                                  _productListController.materialList[index].name ?? "",
                                  style: TextStyle(fontSize: 10),
                                ),
                                value: _productListController.selectedMaterialIndex.value == index,
                                onChanged: (bool? value) {
                                  _productListController.selectedMaterialIndex.value = value! ? index : -1;
                                },
                              );
                            });
                          },
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: Text('Shapes'),
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: _productListController.shapeList.length,
                          itemBuilder: (context, index) {
                            return Obx(() {
                              return CheckboxListTile(

                                contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                                visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                                checkboxShape: RoundedRectangleBorder(side: BorderSide()),
                                activeColor: Colors.purple,
                                title: Text(
                                  _productListController.shapeList[index].name ?? "",
                                  style: TextStyle(fontSize: 10),
                                ),
                                value: _productListController.selectedShapeIndex.value == index,
                                onChanged: (bool? value) {
                                  _productListController.selectedShapeIndex.value = value! ? index : -1;
                                },
                              );
                            });
                          },
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _productListController.productsList.isEmpty
                    ? const Center(child: Text('No Products Found!'))
                    : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:  3,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 1,
                  ),
                  itemCount: _productListController.productsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => Get.toNamed(
                        PageRouteConstant.productDetails,
                        arguments: {'id': _productListController.productsList[index].id},
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                _productListController.productsList[index].images!.isEmpty
                                    ? SizedBox(width:50,child: Center(child: Text('No Image Found')))
                                    : Expanded(
                                      child: Image.network(
                                                                        _productListController.productsList[index].images!.first.image.toString(),
                                      // height: 10,
                                      // width: 50,
                                                                        fit: BoxFit.cover,
                                                                      ),
                                    ),
                                SizedBox(height: 8),
                                Text(
                                  'Save ${_productListController.productsList[index].discountPercent}%',
                                  style: TextStyle(color: Colors.red, fontSize: 12),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '\u{20B9}${_productListController.productsList[index].price.toString()}',
                                      style: TextStyle(color: Colors.grey, decoration: TextDecoration.lineThrough),
                                    ),
                                    Text(
                                      '\u{20B9}${_productListController.productsList[index].discountPrice.toString()}',
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  ],
                                ),
                                Text(
                                  _productListController.productsList[index].name ?? '',
                                  style: TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  _productListController.productsList[index].materialName ?? '',
                                  style: TextStyle(fontSize: 12),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 8),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        bool added = addToCart(_productListController.productsList[index].id ?? 0);
                                        if (added) {
                                          _cartCountController.updateCartCount();
                                        }
                                      },
                                      child: Text(
                                        'Add To Cart',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.purple,
                                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                        textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
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
            ),
          ],
        ),
      ),
    );
  }
}
