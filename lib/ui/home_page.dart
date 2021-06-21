import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_3/provider/bottomnav_provider.dart';

import 'package:restaurant_app_3/ui/detail_restaurant_page.dart';
import 'package:restaurant_app_3/ui/favorites_restaurant_page.dart';
import 'package:restaurant_app_3/ui/restaurant_list_page.dart';
import 'package:restaurant_app_3/ui/search_restaurant_page.dart';
import 'package:restaurant_app_3/ui/settings_page.dart';
import 'package:restaurant_app_3/utils/notification_helper.dart';
import 'package:restaurant_app_3/widgets/platform_widget.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NotificationHelper _notificationHelper = NotificationHelper();

  List<Widget> _listWidget = [
    RestaurantListPage(),
    SearchRestaurantPage(),
    FavoriteRestaurantListPage(),
    SettingsPage(),
  ];

  List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
        icon: Icon(Platform.isIOS ? CupertinoIcons.list_bullet : Icons.public),
        label: "List"),
    BottomNavigationBarItem(
        icon: Icon(Platform.isIOS ? CupertinoIcons.search : Icons.search),
        label: "Search"),
    BottomNavigationBarItem(
        icon: Icon(
            Platform.isIOS ? CupertinoIcons.square_favorites : Icons.favorite),
        label: "Saved"),
    BottomNavigationBarItem(
        icon: Icon(Platform.isIOS ? CupertinoIcons.settings : Icons.settings),
        label: "Setting"),
  ];

  Widget _buildAndroid(BuildContext context) {
    var provider = Provider.of<BottomNavigationBarProvider>(context);

    return Scaffold(
      body: _listWidget[provider.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: provider.currentIndex,
        items: _bottomNavBarItems,
        onTap: (index) {
          provider.currentIndex = index;
        },
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(items: _bottomNavBarItems),
      tabBuilder: (context, index) {
        return _listWidget[index];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BottomNavigationBarProvider>(
      child: PlatformWidget(
        androidBuilder: _buildAndroid,
        iosBuilder: _buildIos,
      ),
      create: (BuildContext context) => BottomNavigationBarProvider(),
    );
  }

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(DetailRestaurantPage.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }
}
