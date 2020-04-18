import 'dart:convert';

import 'package:ne_yesek/models/food.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String id;
  String title;
  String color;
  String image;
  List<Food> foods;

  UserModel({
    this.id,
    this.title,
    this.color,
    this.image,
    this.foods,
  });

  factory UserModel.fromJson(Map<dynamic, dynamic> json) => UserModel(
        id: json["id"],
        title: json["title"],
        color: json["color"],
        image: json["image"],
        foods: List<Food>.from(json["foods"].map((x) => Food.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "color": color,
        "image": image,
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
      };

  UserModel copyWith({
    String id,
    String title,
    String color,
    String image,
    List<Food> foods,
  }) {
    return new UserModel(
      id: id ?? this.id,
      title: title ?? this.title,
      color: color ?? this.color,
      image: image ?? this.image,
      foods: foods ?? this.foods,
    );
  }
}
