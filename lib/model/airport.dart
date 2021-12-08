import 'package:flutter/material.dart';
import 'package:pocketplanes2/model/job.dart';
import 'package:pocketplanes2/model/map_object.dart';

class Airport extends MapObject with ChangeNotifier {
  String _name;
  List<Job> _currentJobs = List.empty(growable: true);
  List<Job> _layovers = List.empty(growable: true);
  int _layoverCapacity = 3;
  bool _locked = false;

  Airport(this._name);

  String get name => this._name;
  List<Job> get currentJobs => this._currentJobs;
  List<Job> get layovers => this._layovers;
  int get layoverCapacity => this._layoverCapacity;
  bool get locked => this._locked;

  set layoverCapacity(int capacity) {
    this._layoverCapacity = capacity;
  }

  set locked(bool isLocked) {
    this._locked = isLocked;
  }

  void addJob(Job job) {
    job.origin = this;
    currentJobs.add(job);
  }

  void unlock() {
    this._locked = false;
    notifyListeners();
  }

  void addLayoverJob(Job job) {
    if(_layovers.length < _layoverCapacity) {
      _layovers.add(job);
      job.addListener(() {
        _layovers.remove(job);
      });
    }
  }

  

  bool unboardJob(Job job) {
    if (job.origin == this) {
      _currentJobs.add(job);
      return true;
    }

    if (_layovers.length < _layoverCapacity) {
      _layovers.add(job);
      job.addListener(() {
        _layovers.remove(job);
      });
      return true;
    }

    return false;
  }

  void upgradeLayoverCapacity() {
    this._layoverCapacity += 3;
  }

  Map<String, dynamic> toJson() => {
        'name': _name,
        'layoverCapacity': _layoverCapacity,
        'x': x,
        'y': y,
        'locked': _locked
      };

  Airport.fromJson(Map<String, dynamic> json)
      : _name = json['name'],
        _layoverCapacity = json['layoverCapacity'],
        _locked = json['locked'],
        super.positioned(json['x'], json['y']);
}
