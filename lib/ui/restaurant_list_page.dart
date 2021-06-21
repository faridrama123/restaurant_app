import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_3/provider/bottomnav_provider.dart';
import 'package:restaurant_app_3/provider/restaurant_provider.dart';
import 'package:restaurant_app_3/widgets/card_restaurant.dart';
import 'package:restaurant_app_3/widgets/platform_widget.dart';

class RestaurantListPage extends StatelessWidget {
  Widget _buildList() {
    return Consumer<RestaurantProvider>(
      builder: (context, provider, _) {
        if (provider.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (provider.state == ResultState.HasData) {
          return ListView.builder(
            // physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: provider.results.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = provider.results.restaurants[index];
              return CardRestaurant(restaurant: restaurant);
            },
          );
        } else if (provider.state == ResultState.NoData) {
          return Center(
              child: Text(
            provider.message,
            textAlign: TextAlign.center,
          ));
        } else if (provider.state == ResultState.Error) {
          return Center(
              child: Text(
            provider.message,
            textAlign: TextAlign.center,
          ));
        } else {
          return Center(child: Text(''));
        }
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          searchSection,
          titleSection(context),
          Expanded(
            child: _buildList(),
          )
        ],
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      child: _buildList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

  Widget titleSection(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsets.only(left: 20, bottom: 5),
                  child: Text("Restaurant",
                      style: Theme.of(context).textTheme.headline5)),
              Container(
                  padding: const EdgeInsets.only(left: 20, bottom: 10),
                  child: Text("Recommendation restaurant for you!",
                      style: Theme.of(context).textTheme.subtitle1))
            ],
          )
        ],
      ),
    );
  }
}

Widget searchSection =
    Consumer<BottomNavigationBarProvider>(builder: (context, state, _) {
  return Container(
    color: Colors.green,
    child: SafeArea(
      child: Container(
        padding: EdgeInsets.only(top: 0, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                icon: Icon(
                  Icons.search,
                ),
                onPressed: () {
                  state.currentIndex = 1;
                }),
          ],
        ),
      ),
    ),
  );
});
