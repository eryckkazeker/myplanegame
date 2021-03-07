import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
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

    var tripCost = flightDistance.toInt() * GameManager.FUEL_COST * airplane.speed~/10;
    debugPrint('Trip cost is \$$tripCost');
    
    return tripCost;
  }

  static int layoverUpgradePrice(Airport airport) {
    return airport.layoverCapacity * PricingConstants.AIRPORT_UPGRADE_PRICE_CONSTANT;
  }

  static int airportPrice() {
    return 2000 * GameManager().unlockedAirports.length;
  }

  static int jobPrice(Airport origin, Airport destination) {
    var random = math.Random();
    var jobDistance = GeographyHelper.distance(origin, destination);
    return jobDistance.toInt() * 10 + (random.nextDouble() * 300 - 25).toInt();
  } 

  static int nextTripProfit(Airplane airplane) {
    int tripCost = EconomyManager.tripCost(airplane, airplane.destinationList);
    int tripRevenue = 0;
    airplane.cargoJobs.forEach((job) {
      if (airplane.destinationList.any((airport) => airport == job.destination)) {
        tripRevenue += job.value;
      }
    });
    airplane.passengerJobs.forEach((job) {
      if (airplane.destinationList.any((airport) => airport == job.destination)) {
        tripRevenue += job.value;
      }
    });

    return tripRevenue - tripCost;
  }

  static int airplaneValue(Airplane airplane) {
    var periods = airplane.totalFlightTime/PricingConstants.AIRPLANE_DEPRECIATION_PERIOD;
    var rate = math.pow(1+PricingConstants.AIRPLANE_DEPRECIATION_RATE, periods);
    return math.max((airplane.price ~/ rate), airplane.price~/2);
  }

}