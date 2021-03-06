import 'package:flutter/material.dart';
import 'package:pocketplanes2/enums/plane_status.dart';
import 'package:pocketplanes2/game_constants/constants.dart';
import 'package:pocketplanes2/util/game_manager.dart';

class PlaneRoutePainter extends CustomPainter {
  final GameManager _manager = GameManager();

  @override
  void paint(Canvas canvas, Size size) {

    _manager.airplanes.forEach((airplane) {
      if (airplane.planeStatus == PlaneStatus.flying) {
        var p1 = Offset(
            airplane.currentAirport.x + PainterConstants.ICON_OFFSET, airplane.currentAirport.y + PainterConstants.ICON_OFFSET);
        var p2 =
            Offset(airplane.destinationList[0].x + PainterConstants.ICON_OFFSET, airplane.destinationList[0].y + PainterConstants.ICON_OFFSET);
        final currentRoutePaint = Paint();
        currentRoutePaint.color = Colors.blue;
        currentRoutePaint.strokeWidth = PainterConstants.ROUTE_STROKE_WIDTH;
        canvas.drawLine(p1, p2, currentRoutePaint);

        if(airplane.destinationList.length > 1) {
          var futureRoutesPaint = Paint();
          futureRoutesPaint.strokeWidth = PainterConstants.ROUTE_STROKE_WIDTH;
          futureRoutesPaint.color = Colors.black;
          for(int i = 0; i < airplane.destinationList.length-1; i++) {
            var p3 = Offset(airplane.destinationList[i+1].x + PainterConstants.ICON_OFFSET, airplane.destinationList[i+1].y + PainterConstants.ICON_OFFSET);
            canvas.drawLine(p2, p3, futureRoutesPaint);
            p2 = p3;
          }
        }
      }

      
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}