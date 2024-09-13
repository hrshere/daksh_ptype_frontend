import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService{
  FirebaseMessaging messaging = FirebaseMessaging.instance;

requestPermissions() async {
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  print('User granted permission: ${settings.authorizationStatus}');

}

listenToForeGroundMessages(){
  //must create "high priority" notification channel on android and for IOS updated the presentation options for the application
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
}

}