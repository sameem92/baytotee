import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';
import '../helpers/custom_trace.dart';
import '../models/route_argument.dart';
import '../repository/settings_repository.dart' as settingRepo;
import '../repository/user_repository.dart' as userRepo;

class SplashScreenController extends ControllerMVC with ChangeNotifier {
  ValueNotifier<Map<String, double>> progress = new ValueNotifier(new Map());
  GlobalKey<ScaffoldState> scaffoldKey;
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  SplashScreenController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    // Should define these variables before the app loaded
    progress.value = {"Setting": 0, "User": 0};
  }

  @override
  void initState() async{
    super.initState();
    Firebase.initializeApp();
    firebaseMessaging.requestPermission(
      alert: true,

      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,

    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async{
      RemoteNotification notification = message.notification;
      String messageId = await settingRepo.getMessageId();


      if (notification != null) {
        Fluttertoast.showToast(

          msg: message.notification.title,
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Color(0xFF4d9f7e),
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 5,



        );
        if (messageId != message.messageId) {
          if (message.data['id'] == "orders") {
            await settingRepo.saveMessageId(message.messageId);

            settingRepo.navigatorKey.currentState.pushReplacementNamed('/Pages', arguments: 2);
            print("11111${message.senderId}");
            print("22222${message.data}");
            print("333333${message.from}");
            print("444444${message.messageType}");
            print("5555${message.notification.body}");
            print("66666${message.notification.title}");
            print("8888${message.notification.apple}");
            print("999999${message.notification.titleLocKey}");

            // Navigator.of(context).pushNamed('/Tracking',
            //     arguments:
            //     RouteArgument(id: widget.order.id));
          }
          if (message.data['id'] == "messages") {
            await settingRepo.saveMessageId(message.messageId);
            // currentUser.value.apiToken == null?Navigator.of(context).pushNamed('/Login'): Navigator.of(context)
            //     .pushNamed('/MessagesWidget'),
            settingRepo.navigatorKey.currentState.pushNamed('/MessagesWidget');          }
        }
      }


    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      String messageId = await settingRepo.getMessageId();
      try {
        if (messageId != message.messageId) {
          if (message.data['id'] == "orders") {
            await settingRepo.saveMessageId(message.messageId);

            settingRepo.navigatorKey.currentState.pushReplacementNamed('/Pages', arguments: 2);
            print("11111${message.senderId}");
            print("22222${message.data}");
            print("333333${message.from}");
            print("444444${message.messageType}");
            print("5555${message.notification.body}");
            print("66666${message.notification.title}");
            print("8888${message.notification.apple}");
            print("999999${message.notification.titleLocKey}");

            // Navigator.of(context).pushNamed('/Tracking',
            //     arguments:
            //     RouteArgument(id: widget.order.id));
          }
          if (message.data['id'] == "messages") {
            await settingRepo.saveMessageId(message.messageId);
            // currentUser.value.apiToken == null?Navigator.of(context).pushNamed('/Login'): Navigator.of(context)
            //     .pushNamed('/MessagesWidget'),
            settingRepo.navigatorKey.currentState.pushNamed('/MessagesWidget');          }
        }
      } catch (e) {
        print(CustomTrace(StackTrace.current, message: e));
      }
    });


    settingRepo.setting.addListener(() {
      if (settingRepo.setting.value.appName != null &&
          settingRepo.setting.value.appName != '' &&
          settingRepo.setting.value.mainColor != null) {
        progress.value["Setting"] = 41;
        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
        progress?.notifyListeners();

      }
    });
    userRepo.currentUser.addListener(() {
      if (userRepo.currentUser.value.auth != null) {
        progress.value["User"] = 59;
        progress?.notifyListeners();

      }
    });
    // Timer(Duration(seconds: 20), () {
    //   ScaffoldMessenger.of(scaffoldKey.currentContext).showSnackBar(SnackBar(
    //     content: Text(S.of(state.context).verify_your_internet_connection),
    //   ));
    // });
  }
}
