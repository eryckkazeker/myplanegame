import 'package:pocketplanes2/game_constants/constants.dart';
import 'package:pocketplanes2/model/airplane.dart';
import 'package:pocketplanes2/model/airport.dart';

class C172M extends Airplane {
  String _modelName = 'C-172 M';

  C172M(String name, Airport airport)
      : super(name, airport,
            range: AirplaneConstants.C172RANGE,
            cargoCapacity: AirplaneConstants.C172M_CAPACITY,
            passengerCapacity: AirplaneConstants.C172M_CAPACITY,
            price: PricingConstants.C172_PRICE,
            speed: SpeedConstants.C172_SPEED);

  @override
  String get modelName => this._modelName;
}
