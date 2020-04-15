import 'dart:math';

import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  FoodCard({this.image, this.title, this.description, this.color});

  final String image;
  final String title;
  final String description;
  final Color color;

  static const List<Color> colorlist = [
    Color(0xFFF5E1BA),
    Color(0xFFEAEEF1),
    Color(0xFFC2D59F),
    Color(0xFFFFC599),
    Color(0xFFF1AEAF),
    Color(0xFFF5E17B),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {},
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 7,
                child: Center(
                  child: Container(
                    height: size.height / 9,
                    width: size.height / 9,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://clipartart.com/images/food-icon-clipart-5.jpg"),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Kiwi",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        "Gurugram Mandi \nHaryana",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: colorlist[Random().nextInt(6)],
        ),
      ),
    );
  }
}
