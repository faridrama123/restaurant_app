import 'dart:async';

import 'package:flutter/material.dart';

import 'package:restaurant_app_3/data/api/api_service.dart';
import 'package:restaurant_app_3/data/model/detail_restaurant.dart';
import 'package:restaurant_app_3/data/model/list_restaurant.dart';
import 'package:restaurant_app_3/data/model/search_restaurant.dart';

enum ResultState { Loading, NoData, HasData, Error }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({
    this.apiService,
  }) {
    _fetchListOfRestaurant();
  }

  ListOfRestaurant _listOfRestaurant;
  ResultState _state;
  String _message = '';

  String get message => _message;
  ListOfRestaurant get results => _listOfRestaurant;
  ResultState get state => _state;

  Future<dynamic> _fetchListOfRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final list = await apiService.listofrestaurant();
      if (list.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _listOfRestaurant = list;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'connection error check network and retry..';
    }
  }
}

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  final String restaurantid;

  DetailRestaurantProvider({
    this.apiService,
    this.restaurantid,
  }) {
    _fetchDetailOfRestaurant(restaurantid);
  }

  DetailOfRestaurant _detailOfRestaurant;
  ResultState _state;
  String _message = '';

  String get message => _message;
  DetailOfRestaurant get results => _detailOfRestaurant;
  ResultState get state => _state;

  Future<dynamic> _fetchDetailOfRestaurant(String restaurantid) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final detail = await apiService.detailofrestaurant(restaurantid);
      if (detail.restaurant == null) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _detailOfRestaurant = detail;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'connection error check network and retry..';
    }
  }
}

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchRestaurantProvider({
    this.apiService,
  }) {
    _fetchSearchOfRestaurant(_query);
  }

  SearchOfRestaurant _searchOfRestaurant;
  ResultState _state;
  String _message = '';
  String _query = '';

  String get query => _query;
  set query(String value) {
    _query = value;
    notifyListeners();
  }

  String get message => _message;
  SearchOfRestaurant get results => _searchOfRestaurant;
  ResultState get state => _state;
  Future<dynamic> get fetchSearchOfRestaurant =>
      _fetchSearchOfRestaurant(_query);

  Future<dynamic> _fetchSearchOfRestaurant(String query) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final list = await apiService.searchofrestaurant(query);
      if (list.restaurants == null) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _searchOfRestaurant = list;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'connection error check network and retry..';
    }
  }
}
