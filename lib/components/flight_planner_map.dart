import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pocketplanes2/components/map/airport_map_object.dart';
import 'package:pocketplanes2/components/painters/plane_range_painter.dart';
import 'package:pocketplanes2/model/airplane.dart';
import 'package:pocketplanes2/util/game_manager.dart';

class FlightPlannerMap extends StatefulWidget {
  final Airplane _airplane;
  final Function _clickCallback;

  FlightPlannerMap(this._airplane, this._clickCallback);

  @override
  _FlightPlannerMapState createState() => _FlightPlannerMapState();
}

class _FlightPlannerMapState extends State<FlightPlannerMap> {
  final GameManager _manager = GameManager();
  final Matrix4 _defaultPosition = Matrix4(0.8, 0.0, 0.0, 0.0, 0.0, 0.8, 0.0,
      0.0, 0.0, 0.0, 0.8, 0.0, -1622, -2026, 0.0, 1.0);
  final _transformationController = TransformationController();

  double rangeTick = 0.0;
  ValueNotifier<double> notifier;
  Timer _timer;

  Stack _gameObjectsStack = Stack(
    children: [
      Container(
        child: Image.asset(
          'assets/world_map.png',
          scale: 0.5,
        ),
      ),
    ],
  );

  @override
  void initState() {
    super.initState();

    notifier = ValueNotifier<double>(rangeTick);

    _gameObjectsStack.children.add(
      Positioned.fill(
        child: Container(
          key: UniqueKey(),
          color: Colors.transparent,
          child: CustomPaint(
            painter:
                PlaneRangePainter(notifier),
          ),
        ),
      )
    );

    _manager.airports.forEach((airport) {
      _gameObjectsStack.children
          .add(AirportMapObject(airport, widget._clickCallback));
    });

    _transformationController.value = _defaultPosition;

    _timer = Timer.periodic(Duration(milliseconds: 30), (timer) {
      setState(() {
        notifier.notifyListeners();
      });
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: InteractiveViewer(
      constrained: false,
      child: _gameObjectsStack,
      transformationController: _transformationController,
    ));
  }

  @override
  void dispose() {
    notifier.dispose();
    _timer.cancel();
    super.dispose();
  }
}
