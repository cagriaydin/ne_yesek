import 'package:flutter/material.dart';

import '../models/user_model.dart';

class FoodDetail extends StatefulWidget {
  final Food food;

  const FoodDetail({
    Key key,
    this.food,
  }) : super(key: key);

  @override
  _FoodDetailState createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {
  final TextEditingController titleController = new TextEditingController();
  final TextEditingController detailController = new TextEditingController();
  final titleStyle = TextStyle(
    fontSize: 27,
    fontWeight: FontWeight.w600,
  );
  final detailStyle = TextStyle(
      fontSize: 15,
      height: 1.5,
      fontWeight: FontWeight.w600,
      color: Color(0xff879D95));

  bool isEditMode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.network(
                    widget.food.image,
                    height: 350,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    height: 350,
                    color: Colors.black12,
                    padding: EdgeInsets.only(top: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                  setState(() {
                                    isEditMode = !isEditMode;
                                  });
                                },
                                child: Icon(
                                  !isEditMode ? Icons.edit : Icons.check,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                              SizedBox(
                                width: 24,
                              ),
                              Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                              )
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
                        widget.food.title,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 27,
                        ),
                      )
                    else
                      TextField(
                        style: titleStyle,
                        cursorColor: Colors.black,
                        controller: titleController,
                        decoration: new InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            isDense: true,
                            hintText: 'Ne hazırladın?',
                            hintStyle: titleStyle,
                            border: InputBorder.none),
                      ),
                    SizedBox(
                      height: 24,
                    ),
                    if (!isEditMode)
                      Text(
                        widget.food.detail,
                        style: TextStyle(
                            fontSize: 15,
                            height: 1.5,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff879D95)),
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
}
