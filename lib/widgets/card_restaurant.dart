import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_3/common/navigation.dart';
import 'package:restaurant_app_3/data/model/detail_restaurant.dart';
import 'package:restaurant_app_3/data/model/list_restaurant.dart';
import 'package:restaurant_app_3/data/model/search_restaurant.dart';
import 'package:restaurant_app_3/provider/database_provider.dart';
import 'package:restaurant_app_3/ui/detail_restaurant_page.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const CardRestaurant({this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Hero(
          tag: "https://restaurant-api.dicoding.dev/images/small/" +
              restaurant.pictureId,
          child: Image.network(
            "https://restaurant-api.dicoding.dev/images/small/" +
                restaurant.pictureId,
            width: 100,
          ),
        ),
        title: Text(
          restaurant.name,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          restaurant.city,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        onTap: () => Navigator.pushNamed(
          context,
          DetailRestaurantPage.routeName,
          arguments: restaurant,
        ),
      ),
    );
  }
}

class CardFavoritesRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const CardFavoritesRestaurant({this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isBookmarked(restaurant.id),
          builder: (context, snapshot) {
            var isBookmarked = snapshot.data ?? false;
            return Material(
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                leading: Hero(
                  tag: "https://restaurant-api.dicoding.dev/images/small/" +
                      restaurant.pictureId,
                  child: Image.network(
                    "https://restaurant-api.dicoding.dev/images/small/" +
                        restaurant.pictureId,
                    width: 100,
                  ),
                ),
                title: Text(
                  restaurant.name,
                ),
                subtitle: Text(restaurant.city ?? ""),
                trailing: isBookmarked
                    ? IconButton(
                        icon: Icon(Icons.bookmark),
                        color: Theme.of(context).accentColor,
                        onPressed: () => provider.removeBookmark(restaurant.id),
                      )
                    : IconButton(
                        icon: Icon(Icons.bookmark_border),
                        color: Theme.of(context).accentColor,
                        onPressed: () => provider.addBookmark(restaurant),
                      ),
                onTap: () => Navigation.intentWithData(
                    DetailRestaurantPage.routeName, restaurant),
              ),
            );
          },
        );
      },
    );
  }
}

class SearchCardRestaurant extends StatelessWidget {
  final SearchRestaurant restaurant;

  const SearchCardRestaurant({this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Hero(
          tag: "https://restaurant-api.dicoding.dev/images/small/" +
              restaurant.pictureId,
          child: Image.network(
            "https://restaurant-api.dicoding.dev/images/small/" +
                restaurant.pictureId,
            width: 100,
          ),
        ),
        title: Text(
          restaurant.name,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          restaurant.city,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        onTap: () => Navigator.pushNamed(
          context,
          DetailRestaurantPage.routeName,
          arguments: restaurant,
        ),
      ),
    );
  }
}
