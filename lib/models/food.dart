import 'dart:convert';

Food userModelFromJson(String str) => Food.fromJson(json.decode(str));

String userModelToJson(Food data) => json.encode(data.toJson());

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
    this.favorite = false,
    this.date,
    this.image =
        'https://image.shutterstock.com/image-photo/healthy-food-clean-eating-selection-260nw-722718097.jpg',
  });

  factory Food.fromJson(Map<dynamic, dynamic> json) => Food(
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

  Food copyWith({
    String id,
    String title,
    String detail,
    String color,
    bool favorite,
    DateTime date,
    String image,
  }) {
    return new Food(
      id: id ?? this.id,
      title: title ?? this.title,
      detail: detail ?? this.detail,
      color: color ?? this.color,
      favorite: favorite ?? this.favorite,
      date: date ?? this.date,
      image: image ?? this.image,
    );
  }
}
