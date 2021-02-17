import 'package:pocketplanes2/model/job.dart';
import 'package:pocketplanes2/model/map_object.dart';

class Airport extends MapObject{
  String _name;
  List<Job> _currentJobs = List<Job>();
  List<Job> _layovers = List<Job>();
  int _layoverCapacity = 2;

  Airport(this._name);

  String get name => this._name;
  List<Job> get currentJobs => this._currentJobs;
  List<Job> get layovers => this._layovers;
  int get layoverCapacity => this._layoverCapacity;

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
}
