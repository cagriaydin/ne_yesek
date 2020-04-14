import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ne_yesek/widgets/foodcard-widget.dart';
import 'package:ne_yesek/widgets/search-widget.dart';

class Home extends StatelessWidget {
  const Home({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          SearchWidget(),
          Expanded(
            child: Container(
              child: GridView.count(
                childAspectRatio: 0.7,
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                padding: EdgeInsets.all(16),
                children: <Widget>[
                  FoodCard(),
                  FoodCard(),
                  FoodCard(),
                  FoodCard(),
                  FoodCard(),
                  FoodCard(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
