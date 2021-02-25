import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pocketplanes2/enums/plane_status.dart';
import 'package:pocketplanes2/model/airplane.dart';
import 'package:pocketplanes2/model/airport.dart';
import 'package:pocketplanes2/model/job.dart';
import 'package:pocketplanes2/model/player.dart';
import 'package:pocketplanes2/util/file_manager.dart';

class GameManager {

  static final GameManager _gameManager = GameManager._internal();
  static const int MAX_JOBS__PER_AIRPORT = 5;
  static const int FUEL_COST = 1;

  GameManager._internal();

  List<Airport> _airports = List<Airport>();
  List<Airplane> _airplanes = List<Airplane>();
  List<Airplane> _store = List<Airplane>();

  Airplane _currentAirplane;

  factory GameManager() {
    return _gameManager;
  }

  

  List<Airport> get airports => this._airports;
  List<Airplane> get airplanes => this._airplanes;
  List<Airplane> get store => this._store;

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

  Future<void> saveGame() async {
    debugPrint('Saving game data');

    debugPrint('Saving player data');
    var playerData = jsonEncode(Player().toJson());
    debugPrint('Player data [$playerData]');

    debugPrint('Saving airplanes');
    var airplaneData = jsonEncode(airplanes.map((e) => e.toJson()).toList());
    debugPrint('Airplanes data [$airplaneData]');

    Map<String, dynamic> layoverMap = Map<String, dynamic>();
    debugPrint('Saving layover jobs');
    airports.forEach((airport) {
      layoverMap[airport.name] = airport.layovers.map((e) => e.toJson()).toList();
    });

    debugPrint('Layover job data[$layoverMap]');

    Map<String, dynamic> saveData = {
      'player': Player().toJson(),
      'airplanes': airplanes.map((e) => e.toJson()).toList(),
      'airports': airports.map((e) => e.toJson()).toList(),
      'layovers': layoverMap
    };

    var saveDataJson = jsonEncode(saveData);
    debugPrint('Savedata: [$saveDataJson]');
    await FileManager.saveDataToFile(saveDataJson);
  }

  void loadGame() async {
    debugPrint('Loading game');
    var gameData = await FileManager.readSaveFile();
    debugPrint('loaded data: [$gameData]');
    var gameDataMap = jsonDecode(gameData);

    debugPrint('loading Player Data');
    Player().balance = gameDataMap['player']['balance'];
    debugPrint('Player balance [${Player().balance}]');
    
    debugPrint('loading airplanes');
    
    var airplaneDataMap = gameDataMap['airplanes'];
    var airplaneList = (airplaneDataMap as List).map((e) {
      var airplane = Airplane.fromJson(e);
      if (airplane.planeStatus == PlaneStatus.flying) {
        airplane.resumeFlight();
      }
      return airplane;
      }).toList();
    GameManager().airplanes.addAll(airplaneList);

    debugPrint('loading airport data');
    var airportDataMap = gameDataMap['airports'];
    (airportDataMap as List).map((e) {
      var airport = airports.firstWhere((element) => element.name == e['name']);
      airport.layoverCapacity = e['layoverCapacity'];
      return airport;
    }).toList();

    debugPrint('loading layover jobs');
    var layoverData = gameDataMap['layovers'];

    var layoverDataMap = (layoverData as Map);

    layoverDataMap.keys.forEach((key) {
      var airport = airports.firstWhere((airport) => airport.name == key);
      var jobList = (layoverDataMap[key] as List).map((job) => Job.fromJson(job)).toList();
      airport.layovers.addAll(jobList);
     });

    debugPrint('Done Loading');
  }
}