import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_3/common/navigation.dart';
import 'package:restaurant_app_3/data/api/api_service.dart';
import 'package:restaurant_app_3/data/db/database_helper.dart';
import 'package:restaurant_app_3/data/model/list_restaurant.dart';
import 'package:restaurant_app_3/data/preferences/preferences_helper.dart';
import 'package:restaurant_app_3/provider/database_provider.dart';
import 'package:restaurant_app_3/provider/preferences_provider.dart';
import 'package:restaurant_app_3/provider/restaurant_provider.dart';
import 'package:restaurant_app_3/provider/scheduling_provider.dart';
import 'package:restaurant_app_3/ui/detail_restaurant_page.dart';
import 'package:restaurant_app_3/ui/home_page.dart';
import 'package:restaurant_app_3/utils/background_service.dart';
import 'package:restaurant_app_3/utils/notification_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestaurantProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => SchedulingProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
      ],
      child: Consumer<PreferencesProvider>(
        builder: (context, provider, _) {
          return MaterialApp(
            title: 'Restaurant App',
            theme: provider.themeData,
            navigatorKey: navigatorKey,
            initialRoute: HomePage.routeName,
            routes: {
              HomePage.routeName: (context) => HomePage(),
              DetailRestaurantPage.routeName: (context) => DetailRestaurantPage(
                    restaurant:
                        ModalRoute.of(context).settings.arguments as Restaurant,
                  ),
            },
          );
        },
      ),
    );
  }
}
