import 'dart:async';

import 'package:pocketplanes2/model/airplane.dart';
import 'package:pocketplanes2/model/airport.dart';
import 'package:pocketplanes2/util/job_generator.dart';

class GameManager {

  static final GameManager _gameManager = GameManager._internal();
  static const int MAX_JOBS__PER_AIRPORT = 5;
  static const int FUEL_COST = 1;

  Timer _timer;

  GameManager._internal();

  List<Airport> _airports = List<Airport>();
  List<Airplane> _airplanes = List<Airplane>();
  Airplane _currentAirplane;

  factory GameManager() {
    return _gameManager;
  }

  

  List<Airport> get airports => this._airports;
  List<Airplane> get airplanes => this._airplanes;

  Airplane get currentAirplane => this._currentAirplane;

  void addAirport(Airport airport) {
    this._airports.add(airport);
  }

  void addPlane(Airplane plane) {
    this._airplanes.add(plane);
  }

  set currentAirplane(Airplane current) {
    this._currentAirplane = current;
  }

}