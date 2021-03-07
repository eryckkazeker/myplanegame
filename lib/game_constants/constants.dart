class AirplaneConstants {
  static const double C172RANGE=21;
  static const double C208RANGE=40;

  static const int C172P_PASSENGER_CAPACITY=2;
  static const int C172C_CARGO_CAPACITY=2;
  static const int C172M_CAPACITY=1;
  
  static const int C208P_PASSENGER_CAPACITY=3;
  static const int C208C_CARGO_CAPACITY=3;
  static const int C208M_PASSENGER_CAPACITY=2;
  static const int C208M_CARGO_CAPACITY=1;

}

class PricingConstants {
  static const int C172_PRICE=10000;
  static const int C208_PRICE=30000;
  static const int AIRPORT_UPGRADE_PRICE_CONSTANT=2000;
  static const int AIRPLANE_DEPRECIATION_PERIOD=100;
  static const double AIRPLANE_DEPRECIATION_RATE=0.05;
}

class SpeedConstants {
  static const int C172_SPEED = 100;
  static const int C208_SPEED = 150;
}

class PainterConstants {
  static const double ICON_OFFSET = 1.5;
  static const double PLANE_OFFSET = 0.75;
  static const double DESTINATION_OFFSET = 1;
  static const double ROUTE_STROKE_WIDTH = 0.3;
  static const double RANGE_STROKE_WIDTH = 0.7;
}
