import 'package:flutter/material.dart';
import 'package:pocketplanes2/model/airport.dart';
import 'package:pocketplanes2/screens/airport_screen.dart';

class AirportMapObject extends StatefulWidget {

  final Airport _airport;

  AirportMapObject(this._airport);

  @override
  _AirportMapObjectState createState() => _AirportMapObjectState();
}

class _AirportMapObjectState extends State<AirportMapObject> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AirportScreen(widget._airport)));
            },
                      child: Column(
        children: [
            Text(widget._airport.name, style: TextStyle(fontSize: 10, color: Colors.blue),),
            Icon(Icons.house, size: 15,)
        ],
      ),
          ),
      left: widget._airport.x,
      top: widget._airport.y,
    );
  }
}