import 'package:flutter/material.dart';
import 'package:ne_yesek/models/food.dart';
import 'package:ne_yesek/repositories/local_storage.dart';

enum DetailMode { show, edit, create }

class FoodDetail extends StatefulWidget {
  final Food food;

  final bool isEditMode;
  final bool createNew;

  const FoodDetail({
    Key key,
    this.food,
    this.isEditMode = false,
    this.createNew = false,
  }) : super(key: key);

  @override
  _FoodDetailState createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {
  final TextEditingController titleController = new TextEditingController();
  final TextEditingController detailController = new TextEditingController();
  bool isEditMode = false;

  Food currentFood;

  @override
  void initState() {
    if (widget.createNew == true) {
      isEditMode = true;
      currentFood = Food();
    } else {
      currentFood = widget.food;
      isEditMode = widget.isEditMode;
      titleController.text = widget.food.title ?? '';
      detailController.text = widget.food.detail ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.network(
                    currentFood.image,
                    height: 350,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    height: 350,
                    color: Colors.black12,
                    padding: EdgeInsets.only(top: 50),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            left: 24,
                            right: 24,
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  if (widget.createNew) {
                                    currentFood.title = titleController.text;
                                    currentFood.detail = detailController.text;
                                    LocalStorage.addFood(currentFood);
                                    Navigator.pop(context);
                                    return;
                                  }
                                  if (isEditMode) {
                                    currentFood.title = titleController.text;
                                    currentFood.detail = detailController.text;
                                    LocalStorage.updateUser();
                                  }
                                  setState(() {
                                    isEditMode = !isEditMode;
                                  });
                                },
                                child: titleController.text.isNotEmpty
                                    ? Icon(
                                        !isEditMode ? Icons.edit : Icons.check,
                                        color: Colors.white,
                                        size: 24,
                                      )
                                    : Container(),
                              ),
                              SizedBox(
                                width: 24,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    currentFood.favorite =
                                        !currentFood.favorite;
                                  });
                                  LocalStorage.updateUser();
                                },
                                child: Icon(
                                  currentFood.favorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 24,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    currentFood.favorite =
                                        !currentFood.favorite;
                                  });
                                  LocalStorage.deleteFood(currentFood);
                                  Navigator.pop(context);
                                  return;
                                },
                                child: Icon(
                                  Icons.delete_outline,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          height: 18,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30))),
                          height: 50,
                        )
                      ],
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (!isEditMode)
                      Text(
                        currentFood.title,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 27,
                        ),
                      )
                    else
                      TextField(
                        onChanged: (text) => setState(() {}),
                        autofocus: true,
                        style: titleStyle,
                        cursorColor: Colors.black,
                        controller: titleController,
                        decoration: new InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          isDense: true,
                          hintText: 'Ne hazırladın?',
                          hintStyle: titleStyle,
                          border: InputBorder.none,
                        ),
                      ),
                    SizedBox(
                      height: 24,
                    ),
                    if (!isEditMode)
                      Text(
                        currentFood.detail,
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.5,
                          fontWeight: FontWeight.w600,
                          color: Color(
                            0xff879D95,
                          ),
                        ),
                      )
                    else
                      TextField(
                        style: detailStyle,
                        maxLines: 3,
                        cursorColor: Colors.black,
                        controller: detailController,
                        decoration: new InputDecoration(
                          contentPadding: EdgeInsets.only(top: 7),
                          hintText: 'Püf noktaları...',
                          hintStyle: detailStyle,
                          border: InputBorder.none,
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  final titleStyle = TextStyle(
    fontSize: 27,
    fontWeight: FontWeight.w600,
  );
  final detailStyle = TextStyle(
      fontSize: 15,
      height: 1.5,
      fontWeight: FontWeight.w600,
      color: Color(0xff879D95));
}
