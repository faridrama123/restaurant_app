import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/detail_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: NewsListPage.routeName,
      routes: {
        NewsListPage.routeName: (context) => NewsListPage(),
        DetailScreen.routeName: (context) => DetailScreen(
              restaurant: ModalRoute.of(context).settings.arguments,
            ),
      },
    );
  }
}

class NewsListPage extends StatelessWidget {
  static const routeName = '/restaurant_list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 50, left: 20),
            color: Colors.green,
            alignment: Alignment.centerLeft,
            child: Text(
              'Restaurant',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 26),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 20, left: 20),
            color: Colors.green,
            alignment: Alignment.centerLeft,
            child: Text(
              'Recommendation restaurant for you!',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Expanded(
            child: FutureBuilder<String>(
              future:
                  DefaultAssetBundle.of(context).loadString('assets/data.json'),
              builder: (context, snapshot) {
                final Welcome welcome = welcomeFromJson(snapshot.data);
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: welcome.restaurants.length,
                    itemBuilder: (context, index) {
                      return _buildListItem(
                          context, welcome.restaurants[index]);
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text("error");
                } else {
                  return Text("loading");
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(BuildContext context, Restaurant restaurant) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Image.network(
        restaurant.pictureId,
        width: 100,
      ),
      title: Text(restaurant.name),
      subtitle: Text(restaurant.city),
      trailing: Text(restaurant.rating.toString()),
      onTap: () {
        Navigator.pushNamed(context, DetailScreen.routeName,
            arguments: restaurant);
      },
    );
  }
}
