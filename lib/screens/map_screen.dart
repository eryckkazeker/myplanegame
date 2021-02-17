import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pocketplanes2/components/airplane_map_object.dart';
import 'package:pocketplanes2/components/airport_map_object.dart';
import 'package:pocketplanes2/components/page_footer.dart';
import 'package:pocketplanes2/enums/plane_status.dart';
import 'package:pocketplanes2/util/game_manager.dart';

class MapScreen extends StatefulWidget {
  final GameManager _manager = GameManager();

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Timer _timer;
  final ScrollController _verticalScrollController = ScrollController(initialScrollOffset: 2500, keepScrollOffset: false);
  final ScrollController _horizontalScrollController = ScrollController(initialScrollOffset: 2050, keepScrollOffset: false);

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

    
    widget._manager.airplanes.forEach((airplane) {
      _gameObjectsStack.children.add(AirplaneMapObject(airplane));
    });

    widget._manager.airports.forEach((airport) {
      _gameObjectsStack.children.add(AirportMapObject(airport));
    });

    setState(() {});

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      log('setting state');
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('World Map')),
      body: SingleChildScrollView(
          controller: _verticalScrollController,
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            controller: _horizontalScrollController,
              scrollDirection: Axis.horizontal, child: _gameObjectsStack),
        ),
      bottomNavigationBar: PageFooter(),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

}

class PlaneRoutePainter extends CustomPainter {
  final GameManager _manager = GameManager();

  @override
  void paint(Canvas canvas, Size size) {
    log('painting');
    
    _manager.airplanes.forEach((airplane) {
      
      if (airplane.planeStatus == PlaneStatus.flying) {
        log('drawing route');
        final p1 = Offset(airplane.currentAirport.x+20, airplane.currentAirport.y+20);
        final p2 = Offset(airplane.destination.x+20, airplane.destination.y+20);
        final paint = Paint();
        paint.color = Colors.black;
        paint.strokeWidth = 2.0;
        canvas.drawLine(p1, p2, paint);
      }
    });
    
    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
