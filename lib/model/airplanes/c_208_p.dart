import 'package:pocketplanes2/game_constants/constants.dart';
import 'package:pocketplanes2/model/airplane.dart';
import 'package:pocketplanes2/model/airport.dart';

class C208P extends Airplane {
  String _modelName = 'C-208 P';

  C208P(String name, Airport airport)
      : super(name, airport,
            range: AirplaneConstants.C208RANGE,
            cargoCapacity: 0,
            passengerCapacity: AirplaneConstants.C208P_PASSENGER_CAPACITY,
            price: PricingConstants.C208_PRICE,
            speed: SpeedConstants.C208_SPEED);

  @override
  String get modelName => this._modelName;
}
