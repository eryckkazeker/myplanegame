import 'package:pocketplanes2/model/airport.dart';

class Player {
  static final Player _player = Player.internal();

  List<Airport> _ownedAirports;
  int _balance;
  int _nextTripProfit = 0;

  factory Player() {
    return _player;
  }

  Player.internal();

  List<Airport> get ownedAirports => this._ownedAirports;
  int get balance => this._balance;
  int get nextTripProfit => this._nextTripProfit;

  void ownAirport(Airport airport) {
    this._ownedAirports.add(airport);
  }

  set balance(int value) {
    this._balance = value;
  }

  set nextTripProfit(int profit) {
    this._nextTripProfit = profit;
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