import 'package:pocketplanes2/game_constants/constants.dart';
import 'package:pocketplanes2/model/airplane.dart';
import 'package:pocketplanes2/model/airport.dart';

class C208M extends Airplane {
  String _modelName = 'C-208 M';

  C208M(String name, Airport airport)
      : super(name, airport,
            range: AirplaneConstants.C208RANGE,
            cargoCapacity: AirplaneConstants.C208M_CARGO_CAPACITY,
            passengerCapacity: AirplaneConstants.C208M_PASSENGER_CAPACITY,
            price: PricingConstants.C208_PRICE);

  @override
  String get modelName => this._modelName;
}
