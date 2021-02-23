import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pocketplanes2/components/map/airplane_map_object.dart';
import 'package:pocketplanes2/components/map/airport_map_object.dart';
import 'package:pocketplanes2/components/painters/plane_route_painter.dart';
import 'package:pocketplanes2/util/game_manager.dart';

class MapComponent extends StatefulWidget {

  final Function _mapClickCallback;

  MapComponent(this._mapClickCallback);

  @override
  _MapComponentState createState() => _MapComponentState();
}

class _MapComponentState extends State<MapComponent> {
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
            painter: PlaneRoutePainter(),
          ),
        ),
      )
    ],
  );

  @override
  void initState() {
    super.initState();

    _manager.airplanes.forEach((airplane) {
      _gameObjectsStack.children.add(AirplaneMapObject(airplane, null));
    });

    _manager.airports.forEach((airport) {
      _gameObjectsStack.children.add(AirportMapObject(airport, widget._mapClickCallback));
    });

    _transformationController.value = _defaultPosition;

    setState(() {});

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
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
