import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app_3/data/model/detail_restaurant.dart';
import 'package:restaurant_app_3/data/model/list_restaurant.dart';
import 'package:restaurant_app_3/data/model/search_restaurant.dart';

class ApiService {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static final String _apiKey = 'YOUR_API_KEY';
  static final String _list = 'list/';
  static final String _detail = 'detail/';
  static final String _search = 'search?q=';

  Future<ListOfRestaurant> listofrestaurant() async {
    final response = await http.get(Uri.parse(_baseUrl + _list));
    if (response.statusCode == 200) {
      return ListOfRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<DetailOfRestaurant> detailofrestaurant(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + _detail + id));
    if (response.statusCode == 200) {
      return DetailOfRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<SearchOfRestaurant> searchofrestaurant(String query) async {
    final response = await http.get(Uri.parse(_baseUrl + _search + query));
    if (response.statusCode == 200) {
      return SearchOfRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }
}
