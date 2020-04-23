import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ne_yesek/models/user_model.dart';
import 'package:ne_yesek/repositories/local_storage.dart';
import 'package:ne_yesek/widgets/foodcard-widget.dart';

class RandomFoodPage extends StatelessWidget {
  GlobalKey<RollSlotState> _rollSlotController = GlobalKey<RollSlotState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Food'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _rollSlotController.currentState.animateToRandomly();
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: LocalStorage.userModelStream,
              builder:
                  (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
                if (snapshot.hasData) {
                  List list = snapshot.data.foods.toList()..shuffle();

                  return RollSlot(
                      rollSlotController: _rollSlotController,
                      itemExtend: 300,
                      children: list
                          .map((f) => Padding(
                                padding: const EdgeInsets.all(36.0),
                                child: FoodCard(
                                  food: f,
                                ),
                              ))
                          .toList());
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RollSlot extends StatefulWidget {
  final GlobalKey<RollSlotState> rollSlotController;

  final List<Widget> children;
  final Duration duration;
  final Curve curve;
  final double speed;

  final double diameterRation;

  final double itemExtend;

  const RollSlot({
    Key key,
    @required this.itemExtend,
    @required this.children,
    this.rollSlotController,
    this.duration = const Duration(milliseconds: 2600),
    this.curve = Curves.elasticInOut,
    this.speed = 0.8,
    this.diameterRation = 1,
  }) : super(key: rollSlotController);

  @override
  RollSlotState createState() => RollSlotState();
}

class RollSlotState extends State<RollSlot> {
  ScrollController _controller = ScrollController();
  List<Widget> currentList = [];

  @override
  void initState() {
    if (widget.children != null && widget.children.isNotEmpty) {
      double d = widget.duration.inMilliseconds / 100;
      while (currentList.length < ((d * widget.speed) / 2)) {
        setState(() {
          currentList.addAll(widget.children.toList()..shuffle());
        });
      }
    }
    super.initState();
  }

  void animateToRandomly() {
//    var animatePosition =
//        _controller.initialScrollOffset == _controller.position.maxScrollExtent
//            ? _controller.position.minScrollExtent
//            : _controller.position.maxScrollExtent;
    _controller.animateTo(
      Random().nextInt(currentList.length) * widget.itemExtend,
      curve: Curves.elasticInOut,
      duration: widget.duration,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListWheelScrollView(
      itemExtent: widget.itemExtend,
      diameterRatio: widget.diameterRation,
      controller: _controller,
      children: currentList.map((widget) {
        return widget;
      }).toList(),
      onSelectedItemChanged: (selectedIndex) {
        print('selected inddex : $selectedIndex');
      },
    );
  }
}
