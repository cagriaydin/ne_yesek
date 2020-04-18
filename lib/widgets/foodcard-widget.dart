import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ne_yesek/models/food.dart';
import 'package:ne_yesek/pages/detail.dart';
import 'package:ne_yesek/repositories/local_storage.dart';

class FoodCard extends StatefulWidget {
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
  _FoodCardState createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return FoodDetail(
            food: widget.food,
          );
        }));
      },
      child: Stack(
        children: <Widget>[
          Container(
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
                            widget.food.image,
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
                          widget.food.title ?? '',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            widget.food.detail == null
                                ? ''
                                : widget.food.detail.length > 25
                                    ? widget.food.detail.substring(0, 30) +
                                        '...'
                                    : widget.food.detail,
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
              color: FoodCard.colorlist[Random().nextInt(6)],
            ),
          ),
          Positioned(
            right: 8,
            top: 8,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  widget.food.favorite = !widget.food.favorite;
                });
                LocalStorage.updateUser();
              },
              child: Icon(
                widget.food.favorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
