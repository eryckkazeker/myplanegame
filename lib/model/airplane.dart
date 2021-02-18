import 'dart:async';

import 'package:pocketplanes2/enums/job_type.dart';
import 'package:pocketplanes2/enums/plane_status.dart';
import 'package:pocketplanes2/model/airport.dart';
import 'package:pocketplanes2/model/job.dart';
import 'package:pocketplanes2/model/map_object.dart';
import 'package:pocketplanes2/model/player.dart';
import 'package:pocketplanes2/util/economy_manager.dart';
import 'package:pocketplanes2/util/geography_helper.dart';

class Airplane extends MapObject{
  String _name;
  double _range;
  int _cargoCapacity;
  int _passengerCapacity;
  List<Job> _cargoJobs = List<Job>();
  List<Job> _passengerJobs = List<Job>();
  Airport _currentAirport;
  Airport _destination;
  PlaneStatus _planeStatus = PlaneStatus.landed;
  Player _player = Player();
  double _flightTime;
  Timer _moveTimer;

  Airplane(String name, Airport airport,
      {double range, int passengerCapacity, int cargoCapacity}) {
        this._name = name;
        this._currentAirport = airport;
        this.x = currentAirport.x;
        this.y = currentAirport.y;
        this._range = range;
        this._passengerCapacity = passengerCapacity;
        this._cargoCapacity = cargoCapacity;
      }

  String get name => this._name;
  double get range => this._range;
  int get cargoCapacity => this._cargoCapacity;
  int get passengerCapacity => this._passengerCapacity;
  List<Job> get cargoJobs => this._cargoJobs;
  List<Job> get passengerJobs => this._passengerJobs;
  Airport get currentAirport => this._currentAirport;
  Airport get destination => this._destination;
  PlaneStatus get planeStatus => this._planeStatus;
  double get flightTime => this._flightTime;

  set destination(Airport airport) {
    this._destination = airport;
  }

  set flightTime(double time) {
    this._flightTime = time;
  }

  set currentAirport(Airport airport) {
    this._currentAirport = airport;
    this.x = currentAirport.x;
    this.y = currentAirport.y;
  }

  int totalJobs() {
    return passengerJobs.length + cargoJobs.length;
  }

  bool boardJob(Job job) {
    if (job.type == JobType.passenger) {
      if(passengerJobs.length < _passengerCapacity) {
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
    if(job.type == JobType.cargo) {
      _cargoJobs.remove(job);
    } else {
      _passengerJobs.remove(job);
    }
  }

  bool fly() {

    int flightCost = EconomyManager.tripCost(this, this.destination);
    if(flightCost > Player().balance) {
      return false;
    }

    if(GeographyHelper.distance(this.currentAirport, this.destination) > this.range) {
      return false;
    }

    Player().pay(flightCost);

    _planeStatus = PlaneStatus.flying;
    flightTime = 30;
    
    Future.delayed(Duration(seconds: flightTime.toInt()), () {
      land();
    });

    _moveTimer = Timer.periodic(Duration(seconds: 1), (timer) { move();});
    
    return true;
    
  }

  void land() {
    currentAirport = destination;
    _destination = null;
    _planeStatus = PlaneStatus.landed;
    _moveTimer.cancel();
    unloadPlane();
  }

  void unloadPlane() {
    _passengerJobs.forEach((job) {
      if(job.destination == _currentAirport) {
        _player.addBalance(job.value);
      }
     });

     _cargoJobs.forEach((job) {
      if(job.destination == _currentAirport) {
        _player.addBalance(job.value);
      }
     });

     _passengerJobs.removeWhere((job) => job.destination == _currentAirport );
     _cargoJobs.removeWhere((job) => job.destination == _currentAirport );
  }

  void move() {
    if (planeStatus != PlaneStatus.flying) {
      return;
    }

    var xDistance = (x-destination.x).abs();
    var yDistance = (y-destination.y).abs();

    if(x > destination.x) x-=(xDistance)/flightTime;
    if(x < destination.x) x+=(xDistance)/flightTime;
    if(y > destination.y) y-=(yDistance)/flightTime;
    if(y < destination.y) y+=(yDistance)/flightTime;

    flightTime--;
  } 
}
