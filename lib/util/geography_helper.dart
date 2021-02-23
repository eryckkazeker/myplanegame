import 'dart:developer';

import 'package:pocketplanes2/model/airplane.dart';
import 'package:pocketplanes2/model/airport.dart';
import 'dart:math' as math;

class GeographyHelper {
  
  static double distance(Airport a1, Airport a2) {
    var xDistance = (a1.x-a2.x).abs();
    var yDistance = (a1.y-a2.y).abs();

    var totalDistance = math.sqrt(math.pow(xDistance, 2) + math.pow(yDistance, 2));

    log('Distance between ${a1.name} and ${a2.name} is $totalDistance');
    return totalDistance;
  }

  static bool isInRange(Airport destination, Airplane airplane) {
    if (distance(destination, airplane.currentAirport) > airplane.range) {
      return false;
    }
    return true;
  }
}