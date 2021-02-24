import 'package:pocketplanes2/game_constants/constants.dart';
import 'package:pocketplanes2/model/airplane.dart';
import 'package:pocketplanes2/model/airport.dart';

class C208C extends Airplane {
  String _modelName = 'C-208 C';

  C208C(String name, Airport airport)
      : super(name, airport,
            range: AirplaneConstants.C208RANGE,
            cargoCapacity: AirplaneConstants.C208C_CARGO_CAPACITY,
            passengerCapacity: 0,
            price: PricingConstants.C208_PRICE,
            speed: SpeedConstants.C208_SPEED);

  @override
  String get modelName => this._modelName;
}
