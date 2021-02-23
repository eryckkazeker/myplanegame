import 'package:pocketplanes2/game_constants/constants.dart';
import 'package:pocketplanes2/model/airplane.dart';
import 'package:pocketplanes2/model/airport.dart';

class C172P extends Airplane {
  String _modelName = 'C-172 P';

  C172P(String name, Airport airport)
      : super(name, airport,
            range: AirplaneConstants.C172RANGE,
            cargoCapacity: 0,
            passengerCapacity: AirplaneConstants.C172P_PASSENGER_CAPACITY,
            price: PricingConstants.C172_PRICE);

  @override
  String get modelName => this._modelName;
}
