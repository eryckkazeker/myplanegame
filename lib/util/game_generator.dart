import 'package:pocketplanes2/model/airplane.dart';
import 'package:pocketplanes2/model/airport.dart';
import 'package:pocketplanes2/model/player.dart';
import 'package:pocketplanes2/util/game_manager.dart';

class GameGenerator {

  static GameManager gameManager = GameManager();
  static Player player = Player();

  GameGenerator();

  static void generateGame() {
    print('Generating game');
    Airport a1 = Airport('Sao Paulo');
    a1.x = 2220;
    a1.y = 2900;
    Airport a2 = Airport('Manaus');
    a2.x = 2050;
    a2.y = 2660;
    Airport a3 = Airport('Recife');
    a3.x = 2390;
    a3.y = 2690;
    Airport a4 = Airport('Porto Alegre');
    a4.x = 2160;
    a4.y = 3000;
    Airport a5 = Airport('Brasilia');
    a5.x = 2220;
    a5.y = 2800;
    Airport a6 = Airport('Rio de Janeiro');
    a6.x = 2270;
    a6.y = 2890;

    gameManager.addAirport(a1);
    gameManager.addAirport(a2);
    gameManager.addAirport(a3);
    gameManager.addAirport(a4);
    gameManager.addAirport(a5);
    gameManager.addAirport(a6);

    Airplane pl1 = Airplane('PL-001',a1, range: 230.00, cargoCapacity: 1, passengerCapacity: 1);
    Airplane pl2 = Airplane('PL-002',a2, range: 230.00, cargoCapacity: 1, passengerCapacity: 1);
    gameManager.addPlane(pl1);
    gameManager.addPlane(pl2);
    

    player.balance = 500;
  }
}