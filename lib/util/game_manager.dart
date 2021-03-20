import 'dart:convert';
import 'dart:typed_data';

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

  GameManager._internal();

  List<Airport> _airports = List.empty(growable: true);
  List<Airport> _unlockedAirports = List.empty(growable: true);
  List<Airplane> _airplanes = List.empty(growable: true);
  List<Airplane> _store = List.empty(growable: true);
  int _timeSinceSave;
  Matrix4 _lastMapPosition;

  Airplane _currentAirplane;

  factory GameManager() {
    return _gameManager;
  }

  

  List<Airport> get airports => this._airports;
  List<Airplane> get airplanes => this._airplanes;
  List<Airplane> get store => this._store;
  List<Airport> get unlockedAirports => this._unlockedAirports;
  Matrix4 get lastMapPosition => this._lastMapPosition;
  Airplane get currentAirplane => this._currentAirplane;
  int get timeSinceSave => this._timeSinceSave;

  void addAirport(Airport airport) {
    this._airports.add(airport);
  }

  void addPlane(Airplane plane) {
    this._airplanes.add(plane);
  }

  set currentAirplane(Airplane current) {
    this._currentAirplane = current;
  }

  set unlockedAirports(List<Airport> unlockedAirportsList) {
    this._unlockedAirports = unlockedAirportsList;
  }

  set lastMapPosition(Matrix4 position) {
    this._lastMapPosition = position;
  }

  Future<void> saveGame() async {
    debugPrint('Saving game data');

    debugPrint('Saving player data');
    var playerData = jsonEncode(Player().toJson());
    debugPrint('Player data [$playerData]');

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
      'layovers': layoverMap,
      'position': _lastMapPosition.storage,
      'savedate': DateTime.now().millisecondsSinceEpoch
    };

    var saveDataJson = jsonEncode(saveData);
    debugPrint('Savedata: [$saveDataJson]');
    await FileManager.saveDataToFile(saveDataJson);
  }

  Future<void> loadGame() async {
    debugPrint('Loading game');
    
    var gameData = await FileManager.readSaveFile();
    debugPrint('loaded data: [$gameData]');
    var gameDataMap = jsonDecode(gameData);

    var currentDate = DateTime.now().millisecondsSinceEpoch;
    var lastSave = (gameDataMap['savedate'] == null) ? currentDate : gameDataMap['savedate'];

    _timeSinceSave = (currentDate - lastSave) ~/ 1000;

    debugPrint('loading Player Data');
    Player().balance = gameDataMap['player']['balance'];
    Player().nextTripProfit = 0;
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
      airport.locked = e['locked'];
      return airport;
    }).toList();

    debugPrint('loading layover jobs');
    var layoverData = gameDataMap['layovers'];

    var layoverDataMap = (layoverData as Map);

    layoverDataMap.keys.forEach((key) {
      var airport = airports.firstWhere((airport) => airport.name == key);
      var jobList = (layoverDataMap[key] as List).map((job) => Job.fromJson(job)).toList();
      
      jobList.forEach((element) {
        airport.addLayoverJob(element);
      });
     });

    unlockedAirports = airports.where((airport) => airport.locked == false).toList();

    debugPrint('Loading map position');

    var positionList = (gameDataMap['position'] as List).map((e) => double.parse(e.toString())).toList();
    
    _lastMapPosition = Matrix4.fromFloat64List(Float64List.fromList(positionList));

    debugPrint('[$_timeSinceSave]s passed since last save');

    debugPrint('Done Loading');
  }
}