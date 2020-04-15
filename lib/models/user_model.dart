import 'dart:convert';

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

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
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
}

class Food {
  String id;
  String title;
  String detail;
  String color;
  bool favorite;
  DateTime date;
  String image;

  Food({
    this.id,
    this.title,
    this.detail,
    this.color,
    this.favorite,
    this.date,
    this.image,
  });

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        id: json["id"],
        title: json["title"],
        detail: json["detail"],
        color: json["color"],
        favorite: json["favorite"],
        date: json["date"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "detail": detail,
        "color": color,
        "favorite": favorite,
        "date": date,
        "image": image,
      };
}
