import 'package:pocketplanes2/model/job.dart';
import 'package:pocketplanes2/model/map_object.dart';

class Airport extends MapObject {
  String _name;
  List<Job> _currentJobs = List<Job>();
  List<Job> _layovers = List<Job>();
  int _layoverCapacity = 3;

  Airport(this._name);

  String get name => this._name;
  List<Job> get currentJobs => this._currentJobs;
  List<Job> get layovers => this._layovers;
  int get layoverCapacity => this._layoverCapacity;

  set layoverCapacity(int capacity) {
    this._layoverCapacity = capacity;
  }

  void addJob(Job job) {
    job.origin = this;
    currentJobs.add(job);
  }

  bool unboardJob(Job job) {
    if (job.origin == this) {
      _currentJobs.add(job);
      return true;
    }

    if (_layovers.length < _layoverCapacity) {
      _layovers.add(job);
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
        'y': y
      };

  Airport.fromJson(Map<String, dynamic> json)
      : _name = json['name'],
        _layoverCapacity = json['layoverCapacity'],
        super.positioned(json['x'], json['y']);
}
