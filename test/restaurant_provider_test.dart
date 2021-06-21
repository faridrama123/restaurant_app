import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:restaurant_app_3/data/model/list_restaurant.dart';

import 'fake_api.dart';

void main() {
  test('Fetch restaurant return list of restaurant', () async {
    final api = FakeRestaurantProvider();

    api.client = MockClient((request) async {
      final jsonMap2 = {
        "error": false,
        "message": "success",
        "count": 20,
        "restaurants": [
          {
            "id": "rqdv5juczeskfw1e867",
            "name": "Melting Pot",
            "description":
                "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
            "pictureId": "14",
            "city": "Medan",
            "rating": 4.2
          }
        ]
      };
      return Response(json.encode(jsonMap2), 200);
    });

    ListOfRestaurant item = await api.fetchFeatures();
    expect(item.message, 'success');
  });

  test('Fetch feature return null', () async {
    final api = FakeRestaurantProvider();

    api.client = MockClient((request) async {
      return Response(json.encode(''), 404);
    });

    try {
      api.fetchFeatures();
    } on NullThrownError catch (e) {
      expect(e.toString(), 'Throw of null.');
    }
  });
}
