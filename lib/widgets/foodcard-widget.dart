import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ne_yesek/pages/detail.dart';

import '../models/user_model.dart';

class FoodCard extends StatelessWidget {
  final Food food;

  static const List<Color> colorlist = [
    Color(0xFFF5E1BA),
    Color(0xFFEAEEF1),
    Color(0xFFC2D59F),
    Color(0xFFFFC599),
    Color(0xFFF1AEAF),
    Color(0xFFF5E17B),
  ];

  const FoodCard({Key key, this.food}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return FoodDetail(
            food: food,
          );
        }));
      },
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
                        food.image,
                      ),
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
                      food.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        food.detail.substring(0,30) + '...',
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
