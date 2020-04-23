import 'package:flutter/material.dart';
import 'package:ne_yesek/pages/random_food_page.dart';
import 'package:ne_yesek/repositories/local_storage.dart';
import 'package:ne_yesek/widgets/foodcard-widget.dart';
import 'package:ne_yesek/widgets/search-widget.dart';

import '../models/user_model.dart';

class Home extends StatefulWidget {
  const Home({
    Key key,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    LocalStorage.getUser();
    super.initState();
  }

  @override
  void dispose() {
    LocalStorage.streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: LocalStorage.userModelStream,
        builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasData) {
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
                              children: snapshot.data.foods.map((f) {
                                return FoodCard(
                                  food: f,
                                );
                              }).toList()),
                        ),
                      )
                    ],
                  ),
                );
              }
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return RandomFoodPage();
          }));
        },
        child: Icon(
          Icons.add,
          color: Colors.black54,
        ),
      ),
    );
  }
}
