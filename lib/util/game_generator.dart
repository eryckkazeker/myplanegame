import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pocketplanes2/model/airplane.dart';
import 'package:pocketplanes2/model/airplanes/c_172_c.dart';
import 'package:pocketplanes2/model/airplanes/c_172_m.dart';
import 'package:pocketplanes2/model/airplanes/c_172_p.dart';
import 'package:pocketplanes2/model/airplanes/c_208_c.dart';
import 'package:pocketplanes2/model/airplanes/c_208_m.dart';
import 'package:pocketplanes2/model/airplanes/c_208_p.dart';
import 'package:pocketplanes2/model/airport.dart';
import 'package:pocketplanes2/model/player.dart';
import 'package:pocketplanes2/util/file_manager.dart';
import 'package:pocketplanes2/util/game_manager.dart';
import 'package:pocketplanes2/util/job_generator.dart';

class GameGenerator {

  static GameManager gameManager = GameManager();
  static JobGenerator jobGenerator = JobGenerator();
  static Player player = Player();
  static Timer timer;

  GameGenerator();

  static void generateGame() async {

    print('Generating game');
    Airport saoPaulo = Airport('Sao Paulo');
    saoPaulo.x = 2220;
    saoPaulo.y = 2900;
    Airport manaus = Airport('Manaus');
    manaus.x = 2050;
    manaus.y = 2660;
    Airport recife = Airport('Recife');
    recife.x = 2390;
    recife.y = 2690;
    Airport portoAlegre = Airport('Porto Alegre');
    portoAlegre.x = 2160;
    portoAlegre.y = 3000;
    Airport brasilia = Airport('Brasilia');
    brasilia.x = 2220;
    brasilia.y = 2800;
    Airport rioDeJaneiro = Airport('Rio de Janeiro');
    rioDeJaneiro.x = 2270;
    rioDeJaneiro.y = 2890;
    Airport curitiba = Airport('Curitiba');
    curitiba.x = 2200;
    curitiba.y = 2950;
    Airport salvador = Airport('Salvador');
    salvador.x = 2350;
    salvador.y = 2750;
    Airport fortaleza = Airport('Fortaleza');
    fortaleza.x = 2360;
    fortaleza.y = 2640;
    Airport belem = Airport('Belem');
    belem.x = 2220;
    belem.y = 2610;
    Airport cuiaba = Airport('Cuiaba');
    cuiaba.x = 2120;
    cuiaba.y = 2795;

    gameManager.addAirport(saoPaulo);
    gameManager.addAirport(manaus);
    gameManager.addAirport(recife);
    gameManager.addAirport(portoAlegre);
    gameManager.addAirport(brasilia);
    gameManager.addAirport(rioDeJaneiro);
    gameManager.addAirport(curitiba);
    gameManager.addAirport(salvador);
    gameManager.addAirport(fortaleza);
    gameManager.addAirport(belem);
    gameManager.addAirport(cuiaba);

    buildStore();
    jobGenerator.generateJobs();

    timer = Timer.periodic(Duration(seconds: 30), (timer) { jobGenerator.generateJobs(); });

    if (await FileManager.saveFileExists()) {
      debugPrint('SAVE FILE EXISTS');
      gameManager.loadGame();
      return;
    }

    debugPrint('SAVE FILE NOT FOUND! GENERATING NEW GAME');

    Airplane pl1 = C172P('PL0001',saoPaulo);
    Airplane pl3 = C172C('PL0002',rioDeJaneiro);
    gameManager.addPlane(pl1);
    gameManager.addPlane(pl3);

    player.balance = 30500;
  }

  static void buildStore() {
    Airplane c172p = C172P('',null);
    Airplane c172m = C172M('',null);
    Airplane c172c = C172C('',null);
    Airplane c208c = C208C('',null);
    Airplane c208m = C208M('',null);
    Airplane c208p = C208P('',null);
    gameManager.store.add(c172p);
    gameManager.store.add(c172m);
    gameManager.store.add(c172c);
    gameManager.store.add(c208p);
    gameManager.store.add(c208m);
    gameManager.store.add(c208c);
  }
}