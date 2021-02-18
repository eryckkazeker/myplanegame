import 'package:flutter/material.dart';
import 'package:pocketplanes2/enums/plane_status.dart';
import 'package:pocketplanes2/util/game_manager.dart';

class PlaneRoutePainter extends CustomPainter {
  final GameManager _manager = GameManager();

  @override
  void paint(Canvas canvas, Size size) {

    _manager.airplanes.forEach((airplane) {
      if (airplane.planeStatus == PlaneStatus.flying) {
        final p1 = Offset(
            airplane.currentAirport.x + 20, airplane.currentAirport.y + 20);
        final p2 =
            Offset(airplane.destination.x + 20, airplane.destination.y + 20);
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