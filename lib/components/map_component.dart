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
  final Matrix4 _defaultPosition = Matrix4(2.7, 0.0, 0.0, 0.0, 0.0, 2.7, 0.0,
      0.0, 0.0, 0.0, 2.7, 0.0, -760, -973, 0.0, 1.0);
  final _transformationController = TransformationController();

  Timer _timer;

  final Stack _gameObjectsStack = Stack(
    children: [
      Container(
        child: Image.asset(
          'assets/world_map.png',
          scale: 3.0,
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

    _transformationController.value = (_manager.lastMapPosition == null) ?
      _defaultPosition :
      _manager.lastMapPosition;

    _manager.airports.forEach((airport) {
      _gameObjectsStack.children.add(AirportMapObject(airport, widget._mapClickCallback));
    });

    _manager.airplanes.forEach((airplane) {
      _gameObjectsStack.children.add(AirplaneMapObject(airplane, null));
    });

    setState(() {});

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: InteractiveViewer(
          onInteractionEnd: (details) {
            _manager.lastMapPosition = _transformationController.value;
          },
      constrained: false,
      child: _gameObjectsStack,
      minScale: 1.0,
      maxScale: 20.0,
      transformationController: _transformationController,
    ));
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
