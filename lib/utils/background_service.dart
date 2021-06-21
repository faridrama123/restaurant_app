import 'dart:ui';
import 'dart:isolate';
import 'dart:math';

import 'package:restaurant_app_3/data/api/api_service.dart';
import 'package:restaurant_app_3/data/model/list_restaurant.dart';
import 'package:restaurant_app_3/main.dart';
import 'package:restaurant_app_3/utils/notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService _instance;
  static String _isolateName = 'nsdfsfs232tr22r';
  static SendPort _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    print('Alarm fired!');
    final NotificationHelper _notificationHelper = NotificationHelper();
    var result = await ApiService().listofrestaurant();

    Random random = new Random();
    var randomNumber = random.nextInt(result.restaurants.length);

    Restaurant restaurant = new Restaurant();
    restaurant = result.restaurants[randomNumber];

    await _notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, restaurant);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
