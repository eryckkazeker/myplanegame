import 'dart:async';
import 'dart:math' as math;

import 'package:pocketplanes2/enums/job_type.dart';
import 'package:pocketplanes2/enums/plane_status.dart';
import 'package:pocketplanes2/model/airport.dart';
import 'package:pocketplanes2/model/job.dart';
import 'package:pocketplanes2/model/map_object.dart';
import 'package:pocketplanes2/model/player.dart';
import 'package:pocketplanes2/util/economy_manager.dart';
import 'package:pocketplanes2/util/game_manager.dart';
import 'package:pocketplanes2/util/geography_helper.dart';

class Airplane extends MapObject {
  int _price;
  String _modelName;
  String _name;
  double _range;
  int _cargoCapacity;
  int _passengerCapacity;
  int _speed;
  List<Job> _cargoJobs = List.empty(growable: true);
  List<Job> _passengerJobs = List.empty(growable: true);
  Airport _currentAirport;
  List<Airport> _destinationList = List.empty(growable: true);
  PlaneStatus _planeStatus = PlaneStatus.landed;
  Player _player = Player();
  double _totalFlightTime;
  double _flightTime;
  double _timePassed = 0;
  Timer _moveTimer;

  Airplane(String name, Airport airport,
      {double range,
      int passengerCapacity,
      int cargoCapacity,
      int price,
      int speed}) {
    this._name = name;
    this._currentAirport = airport;
    this.x = currentAirport?.x;
    this.y = currentAirport?.y;
    this._range = range;
    this._passengerCapacity = passengerCapacity;
    this._cargoCapacity = cargoCapacity;
    this._price = price;
    this._speed = speed;
    this._destinationList = List.empty(growable: true);
    this._totalFlightTime = 0;
  }

  Airplane.clone(Airplane airplane) {
    this._name = airplane.name;
    this._currentAirport = airplane.currentAirport;
    this.x = airplane.currentAirport?.x;
    this.y = airplane.currentAirport?.y;
    this._range = airplane.range;
    this._passengerCapacity = airplane.passengerCapacity;
    this._cargoCapacity = airplane.cargoCapacity;
    this._price = airplane.price;
    this._speed = airplane.speed;
    this._modelName = airplane.modelName;
    this._destinationList = airplane.destinationList;
    this._totalFlightTime = airplane.totalFlightTime;
  }

  String get modelName => this._modelName;
  String get name => this._name;
  double get range => this._range;
  int get cargoCapacity => this._cargoCapacity;
  int get passengerCapacity => this._passengerCapacity;
  int get price => this._price;
  int get speed => this._speed;
  List<Job> get cargoJobs => this._cargoJobs;
  List<Job> get passengerJobs => this._passengerJobs;
  Airport get currentAirport => this._currentAirport;
  List<Airport> get destinationList => this._destinationList;
  PlaneStatus get planeStatus => this._planeStatus;
  double get flightTime => this._flightTime;
  double get totalFlightTime => this._totalFlightTime;

  set destinationList(List<Airport> airportList) {
    this._destinationList = airportList;
  }

  set flightTime(double time) {
    this._flightTime = time;
  }

  set currentAirport(Airport airport) {
    this._currentAirport = airport;
    if (airport != null) {
      this.x = currentAirport.x;
      this.y = currentAirport.y;
    }
  }

  set name(String newName) {
    this._name = newName;
  }

  int totalJobs() {
    return passengerJobs.length + cargoJobs.length;
  }

  bool isFlying() {
    return _planeStatus == PlaneStatus.flying;
  }

  bool boardJob(Job job) {
    if (job.type == JobType.passenger) {
      if (passengerJobs.length < _passengerCapacity) {
        passengerJobs.add(job);
        return true;
      }
    } else {
      if (cargoJobs.length < _cargoCapacity) {
        cargoJobs.add(job);
        return true;
      }
    }
    return false;
  }

  void unboardJob(Job job) {
    if (job.type == JobType.cargo) {
      _cargoJobs.remove(job);
    } else {
      _passengerJobs.remove(job);
    }
  }

  bool canFly() {
    int flightCost = EconomyManager.tripCost(this, this.destinationList);
    if (flightCost > Player().balance) {
      return false;
    }

    if (GeographyHelper.distance(this.currentAirport, this.destinationList[0]) >
        this.range) {
      return false;
    }

    Player().pay(flightCost);
    return true;
  }

  void fly({bool computeTotalTime = false}) {
    _planeStatus = PlaneStatus.flying;
    flightTime =
        GeographyHelper.flightTimeFromDistance(this, this.destinationList[0]);

    if (computeTotalTime) {
      _totalFlightTime += flightTime;
    }

    if(_timePassed <= flightTime) {
      for(int i = 0; i < _timePassed; i++) {
        move();
      }
      Future.delayed(Duration(seconds: flightTime.toInt()), () {
        land();
      });
      _moveTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        move();
      });
      _timePassed -= flightTime;
    } else {
      _timePassed -= flightTime;
      land();
    }
    
    
  }

  void resumeFlight() {
    _timePassed = GameManager().timeSinceSave.toDouble();
    fly();
  }

  void land() {
    currentAirport = destinationList[0];
    destinationList.removeAt(0);
    _planeStatus = PlaneStatus.landed;
    if(_moveTimer != null) {
      _moveTimer.cancel();
    }
    
    unloadPlane();

    if (destinationList.isNotEmpty) {
      fly();
    } else {
      _timePassed = 0;
    }
  }

  void unloadPlane() {
    _passengerJobs.forEach((job) {
      if (job.destination == _currentAirport) {
        _player.addBalance(job.value);
      }
    });

    _cargoJobs.forEach((job) {
      if (job.destination == _currentAirport) {
        _player.addBalance(job.value);
      }
    });

    _passengerJobs.removeWhere((job) => job.destination == _currentAirport);
    _cargoJobs.removeWhere((job) => job.destination == _currentAirport);
  }

  void move() {
    if (planeStatus != PlaneStatus.flying) {
      return;
    }

    var xDistance = (x - destinationList[0].x).abs();
    var yDistance = (y - destinationList[0].y).abs();

    if (x > destinationList[0].x) x -= (xDistance) / flightTime;
    if (x < destinationList[0].x) x += (xDistance) / flightTime;
    if (y > destinationList[0].y) y -= (yDistance) / flightTime;
    if (y < destinationList[0].y) y += (yDistance) / flightTime;

    flightTime--;
  }

  double angleToDestination() {
    if (destinationList.isEmpty) {
      return 0;
    }

    var xDistance = (destinationList[0].x - x);
    var yDistance = -(destinationList[0].y - y);

    var inRads = math.atan2(yDistance, xDistance);

    if (inRads < 0)
      inRads = inRads.abs();
    else
      inRads = 2 * math.pi - inRads;

    return inRads + (math.pi / 2);
  }

  Map<String, dynamic> toJson() => {
        'name': _name,
        'modelName': modelName,
        'currentAirport': _currentAirport?.name,
        'destinationList': _destinationList?.map((e) => e.toJson())?.toList(),
        'planeStatus': _planeStatus.toString(),
        'passengerCapacity': _passengerCapacity,
        'cargoCapacity': _cargoCapacity,
        'range': _range,
        'speed': _speed,
        'passengerJobs': _passengerJobs.map((item) => item.toJson()).toList(),
        'cargoJobs': _cargoJobs.map((item) => item.toJson()).toList(),
        'flightTime': _flightTime,
        'totalFlightTime': _totalFlightTime,
        'price': _price,
        'x': x,
        'y': y
      };

  Airplane.fromJson(Map<String, dynamic> json)
      : _modelName = json['modelName'],
        _name = json['name'],
        _range = json['range'],
        _speed = json['speed'],
        _price = json['price'] ?? 10000,
        _flightTime = json['flightTime'],
        _totalFlightTime = json['totalFlightTime'] ?? 0,
        _passengerCapacity = json['passengerCapacity'],
        _cargoCapacity = json['cargoCapacity'],
        _planeStatus = PlaneStatus.values
            .firstWhere((element) => element.toString() == json['planeStatus']),
        _passengerJobs = (json['passengerJobs'] as List)
            .map((e) => Job.fromJson(e))
            .toList(),
        _cargoJobs =
            (json['cargoJobs'] as List).map((e) => Job.fromJson(e)).toList(),
        _currentAirport = GameManager()
            .airports
            .firstWhere((airport) => airport.name == json['currentAirport']),
        _destinationList = json['destinationList'] == null
            ? null
            : (json['destinationList'] as List)
                .map((e) => GameManager()
                    .airports
                    .firstWhere((airport) => airport.name == e['name']))
                .toList(),
        super.positioned(json['x'], json['y']);
}
