
import 'package:daksh_ptype/features/common/cart_count_controller.dart';
import 'package:daksh_ptype/features/home/home_screen.dart';
import 'package:daksh_ptype/features/notification/notification_service.dart';
import 'package:daksh_ptype/page_routes/store_page_route.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationService().requestPermissions();
  NotificationService().listenToForeGroundMessages();//initially not display by default
  await GetStorage.init();
  final fcmToken = await FirebaseMessaging.instance.getToken(vapidKey: "1-0bo43bg_HQ01ymgFB4Xv4tzaSCk3TxY6JichNjnKM");
  print(fcmToken);
  // initially just use this token, send backgrounded test notifications from firebase console
// Initialize GetStorage
  Get.put(CartCountController());
  // setUrlStrategy(PathUrlStrategy());
  Stripe.publishableKey = 'pk_test_51Pvco22NLuRsyXo4CD4AM3SrvRZHNiH7mwFkMtzaKyzatf7kP6i4bIfZElmrDvP1jU0zgePt3CZQdTIKlXfY7pYg00J5TGAyvR';

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: StorePageRoute.mainPageRoute,
      title: 'Daksh Prototype',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
