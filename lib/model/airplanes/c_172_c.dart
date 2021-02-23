import 'package:pocketplanes2/game_constants/constants.dart';
import 'package:pocketplanes2/model/airplane.dart';
import 'package:pocketplanes2/model/airport.dart';

class C172C extends Airplane {
  String _modelName = 'C-172 C';

  C172C(String name, Airport airport)
      : super(name, airport,
            range: AirplaneConstants.C172RANGE,
            cargoCapacity: AirplaneConstants.C172C_CARGO_CAPACITY,
            passengerCapacity: 0,
            price: PricingConstants.C172_PRICE);

  @override
  String get modelName => this._modelName;
}
