import 'package:flutter/material.dart';

import 'package:pocketplanes2/util/game_manager.dart';

class PlaneRangePainter extends CustomPainter {
  final gameManager = GameManager();

  PlaneRangePainter();

  @override
  void paint(Canvas canvas, Size size) {
    if (gameManager.currentAirplane == null) {
      return;
    }

    final paint = Paint();
    paint.color = Colors.greenAccent;
    paint.strokeWidth = 2.0;
    paint.style = PaintingStyle.stroke;

    var position =
        Offset(gameManager.currentAirplane.x, gameManager.currentAirplane.y);
    var radius = gameManager.currentAirplane.range;

    canvas.drawCircle(position, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
