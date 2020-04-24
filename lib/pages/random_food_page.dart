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
                      onItemSelected: onItemSelected,
                      children: list.map((f) {
                        return FoodCard(
                          food: f,
                        );
                      }).toList());
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }

  void onItemSelected({int currentIndex, Widget currentWidget}) {
    print('callbakc ' + currentIndex.toString());
  }
}

typedef void SelectedItemCallback({
  @required int currentIndex,
  @required Widget currentWidget,
});

class RollSlot extends StatefulWidget {
  final GlobalKey<RollSlotState> rollSlotController;

  final List<Widget> children;
  final Duration duration;
  final Curve curve;
  final double speed;

  final double diameterRation;

  final double itemExtend;

  final double perspective;

  final double squeeze;

  final SelectedItemCallback onItemSelected;

  const RollSlot({
    Key key,
    @required this.itemExtend,
    @required this.children,
    this.rollSlotController,
    this.duration = const Duration(milliseconds: 2600),
    this.curve = Curves.elasticInOut,
    this.speed = 0.6,
    this.diameterRation = 1,
    this.perspective = 0.003,
    this.squeeze = 1.5,
    this.onItemSelected,
  }) : super(key: rollSlotController);

  @override
  RollSlotState createState() => RollSlotState();
}

class RollSlotState extends State<RollSlot> {
  ScrollController _controller = ScrollController();
  List<Widget> currentList = [];

  @override
  void initState() {
    shuffleAndFillTheList();
    addListenerScrollController();
    super.initState();
  }

  void addListenerScrollController() {
    _controller.addListener(() {
      final currentScrollPixels = _controller.position.pixels;
      if (currentScrollPixels % widget.itemExtend == 0) {
        final int currentIndex = currentScrollPixels ~/ widget.itemExtend;
        final Widget currentWidget = currentList.elementAt(currentIndex);
        print('index : $currentIndex');
        if (widget.onItemSelected != null) {
          widget.onItemSelected(
            currentIndex: currentIndex,
            currentWidget: currentWidget,
          );
        }
      }
    });
  }

  void shuffleAndFillTheList() {
    if (widget.children != null && widget.children.isNotEmpty) {
      double d = (widget.duration.inMilliseconds / 100) * widget.speed;
      while (currentList.length < d) {
        setState(() {
          currentList.addAll(widget.children.toList()..shuffle());
        });
      }
    }
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListWheelScrollView(
      itemExtent: widget.itemExtend,
      diameterRatio: widget.diameterRation,
      controller: _controller,
      squeeze: widget.squeeze,
      perspective: widget.perspective,
      children: currentList.map((widget) {
        return widget;
      }).toList(),
      onSelectedItemChanged: (selectedIndex) {
        print('herre');
        print('selected inddex : $selectedIndex');
      },
    );
  }
}
