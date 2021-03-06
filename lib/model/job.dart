import 'package:flutter/material.dart';
import 'package:pocketplanes2/enums/job_type.dart';
import 'package:pocketplanes2/model/airport.dart';
import 'package:pocketplanes2/util/game_manager.dart';

class Job with ChangeNotifier{
  JobType _type;
  Airport _destination;
  Airport _origin;
  int _value;
  bool _deleted = false;

  Job(this._destination, this._type, this._value);

  JobType get type => this._type;
  Airport get destination => this._destination;
  Airport get origin => this._origin;
  int get value => this._value;

  set origin(Airport airport) {
    this._origin = airport;
  }

  void delete() {
    this._deleted = true;
    notifyListeners();
  }

  Map<String, dynamic> toJson() => {
    'jobType': _type.toString(),
    'destination': _destination.name,
    'origin': _origin.name,
    'value': _value
  };

  Job.fromJson(Map<String,dynamic> json)
    : _destination = GameManager().airports.firstWhere((airport) => airport.name == json['destination']),
    _origin = GameManager().airports.firstWhere((airport) => airport.name == json['origin']),
    _type = JobType.values.firstWhere((type) => type.toString() == json['jobType']),
    _value = json['value'];
}