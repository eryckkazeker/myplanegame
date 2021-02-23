import 'package:pocketplanes2/model/airport.dart';

class Player {
  static final Player _player = Player.internal();

  List<Airport> _ownedAirports;
  int _balance;

  factory Player() {
    return _player;
  }

  Player.internal();

  List<Airport> get ownedAirports => this._ownedAirports;
  int get balance => this._balance;

  void ownAirport(Airport airport) {
    this._ownedAirports.add(airport);
  }

  set balance(int value) {
    this._balance = value;
  }

  void addBalance(int value) {
    this._balance += value;
  }

  void pay(int value) {
    this.balance -= value;
  }

  Map<String, dynamic> toJson() => {
    'balance': _balance
  };
}