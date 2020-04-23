import 'dart:async';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ne_yesek/models/food.dart';
import 'package:ne_yesek/models/user_model.dart';
import 'package:rxdart/rxdart.dart';

class LocalStorage {
  static UserModel currentUser = UserModel(
    id: "1",
    image: "",
    foods: [
      Food(
        id: "1",
        date: DateTime.now(),
        title: "My Food",
        detail:
            "lorem ipisum lorem ipisum lorem ipisumlorem ipisum lorem ipisum lorem ipisumlorem ipisum lorem ipisum lorem ipisumlorem ipisum lorem ipisum lorem ipisum",
        image:
            'https://image.shutterstock.com/image-photo/healthy-food-clean-eating-selection-260nw-722718097.jpg',
      ),
    ],
  );

  static StreamController<UserModel> streamController = BehaviorSubject();
  static Stream<UserModel> userModelStream = streamController.stream;

  static Future<UserModel> getUser() async {
    await Hive.initFlutter();
    Box box = await Hive.openBox('userBox');
    await fillUser(box);
    var boxOutput = box.getAt(0);
    currentUser = UserModel.fromJson(boxOutput);
    streamController.add(currentUser);
    return currentUser;
  }

  static Future fillUser(Box box) async {
    if (box.isEmpty) {
      await box.add(currentUser.toJson());
    }
  }

  static Future<dynamic> updateUser() async {
    Box box = await Hive.openBox('userBox');
    await box.putAt(0, currentUser.toJson());
    await getUser();
  }

  static Future<dynamic> addFood(Food food) async {
    Box box = await Hive.openBox('userBox');
    currentUser.foods.add(food);
    await box.putAt(0, currentUser.toJson());
    await getUser();
  }

  static Future<dynamic> deleteUser() async {
    await Hive.initFlutter();
    Box box = await Hive.openBox('userBox');
    box.deleteFromDisk();
  }
}
