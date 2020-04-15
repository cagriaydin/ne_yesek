import 'package:flutter/material.dart';
import 'package:ne_yesek/widgets/foodcard-widget.dart';
import 'package:ne_yesek/widgets/search-widget.dart';

import '../models/user_model.dart';

class Home extends StatelessWidget {
  const Home({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
                    FoodCard(
                      food: Food(
                          image:
                              'https://image.shutterstock.com/image-photo/healthy-food-clean-eating-selection-260nw-722718097.jpg',
                          date: DateTime.now(),
                          title: "My Food",
                          detail:
                              "lorem ipisum lorem ipisum lorem ipisumlorem ipisum lorem ipisum lorem ipisumlorem ipisum lorem ipisum lorem ipisumlorem ipisum lorem ipisum lorem ipisum",
                          id: "1"),
                    ),
                    FoodCard(
                      food: Food(
                          image:
                              'https://image.shutterstock.com/image-photo/healthy-food-clean-eating-selection-260nw-722718097.jpg',
                          date: DateTime.now(),
                          title: "My Food",
                          detail:
                              "lorem ipisum lorem ipisum lorem ipisumlorem ipisum lorem ipisum lorem ipisumlorem ipisum lorem ipisum lorem ipisumlorem ipisum lorem ipisum lorem ipisum",
                          id: "1"),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {},
        child: Icon(
          Icons.add,
          color: Colors.black54,
        ),
      ),
    );
  }
}
