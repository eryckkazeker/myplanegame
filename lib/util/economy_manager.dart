import 'package:pocketplanes2/game_constants/constants.dart';
import 'package:pocketplanes2/model/airplane.dart';
import 'package:pocketplanes2/model/airport.dart';
import 'package:pocketplanes2/util/game_manager.dart';
import 'package:pocketplanes2/util/geography_helper.dart';

class EconomyManager {
  //TODO total distance should come from geography helper
  static int tripCost(Airplane airplane, List<Airport> destinationList) {
    Airport startPoint = airplane.currentAirport;
    double flightDistance = 0;
    destinationList.forEach((destination) {
      flightDistance += GeographyHelper.distance(startPoint, destination);
      startPoint = destination;
    });
    return flightDistance.toInt() * GameManager.FUEL_COST;
  }

  static int layoverUpgradePrice(Airport airport) {
    return airport.layoverCapacity * PricingConstants.AIRPORT_UPGRADE_PRICE_CONSTANT;
  }

}