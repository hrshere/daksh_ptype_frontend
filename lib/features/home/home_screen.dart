import 'package:daksh_ptype/features/common/cart_count_controller.dart';
import 'package:daksh_ptype/features/home/home_controller.dart';
import 'package:daksh_ptype/page_routes/page_route_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../api_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final CartCountController _cartCountController = Get.find();
  final HomeController _homeController = Get.put(HomeController());
  final List<String> categories = ["Tray", "Accessories", "Other"]; // Add your categories here
  String selectedCategory = "Tray"; // Default selected category
  final String djangoAdminUrl = 'https://hrshere.pythonanywhere.com/admin/login/?next=/admin/';

  // Function to launch the URL
  void _launchURL() async {
    if (await canLaunch(djangoAdminUrl)) {
      await launch(djangoAdminUrl);
    } else {
      throw 'Could not launch $djangoAdminUrl';
    }
  }

  final List<Color> categoryColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.cyan,
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(onPressed: (){_launchURL();}, child: const Text('Go To Admin Portal')),
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
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Select Categories To Buy!',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _homeController.categoryList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed('/productList/${_homeController.categoryList[index].id}', arguments: {'category': _homeController.categoryList[index].id});
                    },
                    child: Container(
                      margin: EdgeInsets.all(8.0),
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: categoryColors[index % categoryColors.length],
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _homeController.categoryList[index].name ?? '',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
