import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pocketplanes2/game_constants/constants.dart';

import 'package:pocketplanes2/util/game_manager.dart';

//TODO rename to FlightPlanPainter
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
    paint.strokeWidth = PainterConstants.RANGE_STROKE_WIDTH;
    paint.style = PaintingStyle.stroke;

    var initialPosition = Offset(
        gameManager.currentAirplane.x+PainterConstants.ICON_OFFSET, gameManager.currentAirplane.y+PainterConstants.ICON_OFFSET);

    var position = initialPosition;

    if(gameManager.currentAirplane.destinationList.length > 0) {
      var positionIndex = gameManager.currentAirplane.destinationList.length-1;
      position = Offset(
        gameManager.currentAirplane.destinationList[positionIndex].x+PainterConstants.ICON_OFFSET, 
        gameManager.currentAirplane.destinationList[positionIndex].y+PainterConstants.ICON_OFFSET);
    }

    var radius = gameManager.currentAirplane.range;

    canvas.drawCircle(position, radius, paint);

    position = initialPosition;
    
    if (gameManager.currentAirplane.destinationList != null) {
      gameManager.currentAirplane.destinationList.forEach((destination) {
        var destinationPosition = Offset(
          destination.x+PainterConstants.DESTINATION_OFFSET,
          destination.y+PainterConstants.DESTINATION_OFFSET);
      canvas.drawLine(position, destinationPosition, paint);
      position = destinationPosition;
      });
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    log('should repaint? true');
    return true;
  }

}
