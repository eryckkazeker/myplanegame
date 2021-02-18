import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pocketplanes2/enums/plane_status.dart';
import 'package:pocketplanes2/model/airplane.dart';

class AirplaneMapObject extends StatefulWidget {
  final Airplane _airplane;

  AirplaneMapObject(this._airplane);

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
            log('plane clicked');
            //Navigator.push(context, MaterialPageRoute(builder: (context) => AirportScreen(widget._airport)));
          },
          child: Column(
            children: [
              Text(
                widget._airplane.name,
                style: TextStyle(fontSize: 10, color: Colors.blue),
              ),
              Icon(
                Icons.flight_takeoff,
                size: 15,
              )
            ],
          ),
        ),
      ),
      left: widget._airplane.x,
      top: widget._airplane.y,
    );
  }
}
