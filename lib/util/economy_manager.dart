import 'package:pocketplanes2/model/airplane.dart';
import 'package:pocketplanes2/model/airport.dart';
import 'package:pocketplanes2/util/game_manager.dart';
import 'package:pocketplanes2/util/geography_helper.dart';

class EconomyManager {
  static int tripCost(Airplane airplane, Airport destination) {
    double flightDistance = GeographyHelper.distance(airplane.currentAirport, destination);
    return flightDistance.toInt() * GameManager.FUEL_COST;
  }

}