import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:irrigation1/src/screens/routes.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('payload: ${message.data}');
}

// void handleMessage(RemoteMessage? message) {
//   if (message == null) return;

//   navigatorKey.currentState?.pushNamed(
//     Routes.mainRoute.values.first;
//   )
// }

//This is doing thesame work with this other three functions
//requestPermission
//getToken
class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final database = FirebaseDatabase.instance.ref();

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'irrigation',
    description: 'This channel is used for important notification',
    importance: Importance.defaultImportance,
  );

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fcmtoken = await _firebaseMessaging.getToken();
    print('Token: $fcmtoken');
    savetoken(fcmtoken);
    await initPushNotification();
    await initLocalNotifications();
  }

  Future initLocalNotifications() async {
    print('Testing backgroundNotification');
    const androidInitialize =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initiailizationSettings =
        InitializationSettings(android: androidInitialize);
    await flutterLocalNotificationsPlugin.initialize(
      initiailizationSettings,
      onDidReceiveNotificationResponse: (details) {
        final message = RemoteMessage.fromMap(jsonDecode(details.payload!));
        Routes.mainRoute.values.first;
      },
    );

    final platform =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);

      FirebaseMessaging.onMessage.listen((message) {
      print("Listening to the message");
      final notification = message.notification;
      if (notification == null) return;

      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
              android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: '@drawable/ic_launcher',
          )),
          payload: jsonEncode(message.toMap()));
    });
  }

  Future initPushNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance.getInitialMessage().then((value) {
      Routes.mainRoute.values.first;
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      Routes.mainRoute.values.first;
      //or to TURN ON OR OFF THE PUMPING MACHINE.
    });
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  Future<bool> savetoken(String? token) async {
    database.update({'token': token}).then((value) {
      print('token successfully saved into the database.');
    });
    return true;
  }
}

// void requestPermission() async {
//   FirebaseMessaging messaging = FirebaseMessaging.instance;

//   NotificationSettings settings = await messaging.requestPermission(
//     alert: true,
//     announcement: false,
//     badge: true,
//     carPlay: false,
//     criticalAlert: false,
//     provisional: false,
//     sound: true,
//   );
//   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//     print('User granted permission');
//   } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
//     print('User granted provisional permission');
//   } else {
//     print('User declined or has not accepted permission');
//   }
// }

// void getToken() async {
//   await FirebaseMessaging.instance.getToken();
// }

// initInfo() {
//   var androidInitialize =
//       const AndroidInitializationSettings('@mipmap/ic_launcher');
//   var initiailizationSettings =
//       InitializationSettings(android: androidInitialize);

//   flutterLocalNotificationsPlugin.initialize(
//     initiailizationSettings,
//     // onDidReceiveNotificationResponse: (details) {
//     //   try {
//     //     if(details.payload != null && details.payload!.isNotEmpty){
//     //       Navigator.push(BuildContext context, MaterialPageRoute(builder: (BuildContext context){
//     //         return WeatherScreen();
//     //       }));
//     //     } else{}
//     //   } catch(e){}
//     // },
//   );

//   FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//     print(".........onMessage..................");
//     print(
//         "onMessage: ${message.notification?.title}/${message.notification?.body}");

//     BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
//         message.notification!.body.toString(),
//         htmlFormatBigText: true,
//         contentTitle: message.notification!.title.toString(),
//         htmlFormatTitle: true);

//     AndroidNotificationDetails androidPlatforrmChannelSpecifics =
//         AndroidNotificationDetails(
//       "irrigation",
//       "irrigation",
//       importance: Importance.high,
//       styleInformation: bigTextStyleInformation,
//       priority: Priority.high,
//       playSound: true,
//     );

//     NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatforrmChannelSpecifics);

//     await flutterLocalNotificationsPlugin.show(0, message.notification?.title,
//         message.notification?.body, platformChannelSpecifics,
//         payload: message.data['title']);
//   });
// }


// void sendPushMessage(String token, String body, String title) async {
//   try {
//     await http.post(
//       Uri.parse('https://fcm.googleapis.com/fcm/send'),
//       Headers:<String, String>{
//         'content-Type':'application/json',
//         'Authorization':'Key=SERVER_KEY'
//       },
//       body: jsonEncode(
//         <String, dynamic>{
//           'priority': 'high',
//           'data':<String, dynamic>{
//             'click_action': 'FLUTTER_NOTIFICATION_CLICK',
//             'status':'done',
//             'body':body,
//             'title': title,
//           },
//           "notification":<String, dynamic>{
//             "title": title,
//             "body":body,
//             "android_channel_id":"dbfood"
//           },
//           "to": token,
//         }
//       )
//     );
//   } catch(e){

//   }
// }
