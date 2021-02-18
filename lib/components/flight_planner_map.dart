import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pocketplanes2/components/airport_map_object.dart';
import 'package:pocketplanes2/components/plane_range_painter.dart';
import 'package:pocketplanes2/components/plane_route_painter.dart';
import 'package:pocketplanes2/model/airplane.dart';
import 'package:pocketplanes2/util/game_manager.dart';

class FlightPlannerMap extends StatefulWidget {
  final Airplane _airplane;

  FlightPlannerMap(this._airplane);
  
  @override
  _FlightPlannerMapState createState() => _FlightPlannerMapState();
}

class _FlightPlannerMapState extends State<FlightPlannerMap> {
  final GameManager _manager = GameManager();
  final Matrix4 _defaultPosition = Matrix4(0.8, 0.0, 0.0, 0.0, 0.0, 0.8, 0.0,
      0.0, 0.0, 0.0, 0.8, 0.0, -1622, -2026, 0.0, 1.0);
  final _transformationController = TransformationController();

  Timer _timer;

  final Stack _gameObjectsStack = Stack(
    children: [
      Container(
        child: Image.asset(
          'assets/world_map.png',
          scale: 0.5,
        ),
      ),
      Positioned.fill(
        child: Container(
          width: 200,
          height: 200,
          color: Colors.transparent,
          child: CustomPaint(
            painter: PlaneRangePainter(),
          ),
        ),
      )
    ],
  );

  @override
  void initState() {
    super.initState();

    _manager.airports.forEach((airport) {
      _gameObjectsStack.children.add(AirportMapObject(airport));
    });

    _transformationController.value = _defaultPosition;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      log('plane x=${widget._airplane.x}\nplane y=${widget._airplane.y}\npos12=${_transformationController.value[12]}\npos13=${_transformationController.value[13]}');
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
    _timer.cancel();
    super.dispose();
  }
}
