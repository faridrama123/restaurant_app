import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = '/detail_screen';

  final Restaurant restaurant;

  DetailScreen({@required this.restaurant});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(restaurant.pictureId),
              ),
              SafeArea(
                  child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_rounded),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              )),
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 15, left: 20),
            alignment: Alignment.centerLeft,
            child: Text(
              restaurant.name,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 24),
            ),
          ),
          Container(
              padding: EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
              child: Wrap(
                children: [
                  Icon(
                    Icons.location_city_outlined,
                    size: 20,
                  ),
                  Text(" "),
                  Text(
                    restaurant.city,
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                ],
              )),
          Container(
            padding: EdgeInsets.only(
              top: 15,
              left: 10,
              right: 10,
            ),
            alignment: Alignment.center,
            child: Text(
              restaurant.description,
              textAlign: TextAlign.justify,
              style: TextStyle(color: Colors.black, fontSize: 17),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 15, left: 20, bottom: 15),
            alignment: Alignment.centerLeft,
            child: Text(
              "Foods",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 17),
            ),
          ),
          Container(
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              height: 100.0,
              child: ListFood(
                  menus: restaurant.menus.foods, icon: Icons.fastfood)),
          Container(
            padding: EdgeInsets.only(top: 15, left: 20, bottom: 15),
            alignment: Alignment.centerLeft,
            child: Text(
              "Drink",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 17),
            ),
          ),
          Container(
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              height: 100.0,
              child: ListFood(
                menus: restaurant.menus.drinks,
                icon: Icons.local_drink_sharp,
              ))
        ],
      ),
    ));
  }
}

// ignore: must_be_immutable
class ListFood extends StatelessWidget {
  final List<Drink> menus;
  IconData icon;

  ListFood({@required this.menus, this.icon});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: menus.map((item) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
            ),
            Container(
              width: 90,
              child: Text(
                item.name,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
