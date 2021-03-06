import 'package:flutter/material.dart';
import 'package:pocketplanes2/model/airport.dart';

class AirportMapObject extends StatefulWidget {
  final Airport _airport;
  final Function _clickCallBack;

  AirportMapObject(this._airport, this._clickCallBack);

  @override
  _AirportMapObjectState createState() => _AirportMapObjectState();
}

class _AirportMapObjectState extends State<AirportMapObject>{


  @override
  void initState() {
    super.initState();

    widget._airport.addListener(() {
      debugPrint('${widget._airport.name} locked is [${widget._airport.locked}]');
      setState(() {
        
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Container(
        alignment: Alignment.topLeft,
        child: GestureDetector(
          onTap: () {
            widget._clickCallBack(context, widget._airport);
          },
          child: Container(
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Icon(
                      Icons.house,
                      size: 3,
                      color: (widget._airport.locked) ? Colors.red : Colors.black,
                    )),
                Text(
                  widget._airport.name,
                  style: TextStyle(
                      fontSize: 2,
                      color: Colors.blue,
                      backgroundColor: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
      left: widget._airport.x,
      top: widget._airport.y,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
