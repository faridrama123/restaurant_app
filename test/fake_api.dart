import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:restaurant_app_3/data/model/list_restaurant.dart';

class FakeRestaurantProvider {
  Client client = Client();

  static final String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static final String _list = 'list/';

  fetchFeatures() async {
    final response = await client.get(Uri.parse(_baseUrl + _list));
    if (response.statusCode == 200) {
      return ListOfRestaurant.fromJson(json.decode(response.body));
    } else {
      throw NullThrownError();
    }
  }
}
