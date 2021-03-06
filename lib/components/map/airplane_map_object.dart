import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pocketplanes2/enums/plane_status.dart';
import 'package:pocketplanes2/game_constants/constants.dart';
import 'package:pocketplanes2/model/airplane.dart';

class AirplaneMapObject extends StatefulWidget {
  final Airplane _airplane;
  final Function _clickCallback;

  AirplaneMapObject(this._airplane, this._clickCallback);

  @override
  _AirplaneMapObjectState createState() => _AirplaneMapObjectState();
}

class _AirplaneMapObjectState extends State<AirplaneMapObject> {
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Opacity(
        opacity: (widget._airplane.planeStatus == PlaneStatus.flying) ? 1 : 0,
        child: GestureDetector(
          onTap: () {
            widget._clickCallback(widget._airplane);
          },
          child: Column(
            children: [
              Text(
                widget._airplane.name,
                style: TextStyle(fontSize: 1, color: Colors.blue, backgroundColor: Colors.white),
              ),
              Transform.rotate(
                angle: widget._airplane.angleToDestination(),
                              child: Icon(
                  Icons.airplanemode_active,
                  size: 3,
                ),
              )
            ],
          ),
        ),
      ),
      left: widget._airplane.x-PainterConstants.PLANE_OFFSET,
      top: widget._airplane.y-PainterConstants.PLANE_OFFSET,
    );
  }
}
