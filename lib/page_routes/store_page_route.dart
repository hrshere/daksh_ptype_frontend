
import 'package:daksh_ptype/features/cart/cart_screen.dart';
import 'package:daksh_ptype/features/home/home_screen.dart';
import 'package:daksh_ptype/features/product/screen/product_list_screen.dart';
import 'package:daksh_ptype/features/product_details/product_details_screen.dart';
import 'package:daksh_ptype/page_routes/page_route_constant.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';


class StorePageRoute {
  static List<GetPage> mainPageRoute = [

    // GetPage(name: PageRouteConstant.loginScreen, page: () => LoginScreen()),
    GetPage(name: PageRouteConstant.home, page: () => HomeScreen()),
    GetPage(name: '/productList/:id', page: () => ProductListScreen()),
    GetPage(name: PageRouteConstant.productDetails, page: () => ProductDetailsScreen()),
    GetPage(name: PageRouteConstant.cart, page: () => CartScreen()),





  ];
}

