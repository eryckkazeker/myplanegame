import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:pocketplanes2/util/game_manager.dart';

class PlaneRangePainter extends CustomPainter {
  final gameManager = GameManager();

  ValueNotifier<double> notifier;

  PlaneRangePainter(Listenable notifier) : super(repaint: notifier) {
    this.notifier = notifier;
  }

  @override
  void paint(Canvas canvas, Size size) {
    log('range painting');
    if (gameManager.currentAirplane == null) {
      return;
    }

    final paint = Paint();
    paint.color = Colors.green[800];
    paint.strokeWidth = 2.0;
    paint.style = PaintingStyle.stroke;

    var position = Offset(
        gameManager.currentAirplane.x+10, gameManager.currentAirplane.y+10);
    var radius = gameManager.currentAirplane.range;

    canvas.drawCircle(position, radius, paint);

    if (gameManager.currentAirplane.destination != null) {
      var destinationPosition = Offset(
          gameManager.currentAirplane.destination.x+10,
          gameManager.currentAirplane.destination.y+10);
      canvas.drawLine(position, destinationPosition, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    log('should repaint? true');
    return true;
  }

}
