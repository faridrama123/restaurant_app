// To parse this JSON data, do
//
//     final listOfRestaurant = listOfRestaurantFromJson(jsonString);

import 'dart:convert';

SearchOfRestaurant listOfRestaurantFromJson(String str) =>
    SearchOfRestaurant.fromJson(json.decode(str));

class SearchOfRestaurant {
  SearchOfRestaurant({
    this.error,
    this.message,
    this.founded,
    this.restaurants,
  });

  bool error;
  String message;
  int founded;
  List<SearchRestaurant> restaurants;

  factory SearchOfRestaurant.fromJson(Map<String, dynamic> json) =>
      SearchOfRestaurant(
        error: json["error"],
        message: json["message"],
        founded: json["founded"],
        restaurants: List<SearchRestaurant>.from(
            json["restaurants"].map((x) => SearchRestaurant.fromJson(x))),
      );
}

class SearchRestaurant {
  SearchRestaurant({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
  });

  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  factory SearchRestaurant.fromJson(Map<String, dynamic> json) =>
      SearchRestaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
      );
}
