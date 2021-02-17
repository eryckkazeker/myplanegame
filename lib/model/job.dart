import 'package:pocketplanes2/enums/job_type.dart';
import 'package:pocketplanes2/model/airport.dart';

class Job {
  JobType _type;
  Airport _destination;
  Airport _origin;
  int _value;

  Job(this._destination, this._type, this._value);

  JobType get type => this._type;
  Airport get destination => this._destination;
  Airport get origin => this._origin;
  int get value => this._value;

  set origin(Airport airport) {
    this._origin = airport;
  }
}