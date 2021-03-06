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

    debugPrint('Generating game');

    // Brazil

    Airport saoPaulo = Airport('Sao Paulo');
    saoPaulo.x = 372.17;
    saoPaulo.y = 482.80;
    Airport manaus = Airport('Manaus');
    manaus.x = 343.60;
    manaus.y = 443.73;
    Airport recife = Airport('Recife');
    recife.x = 400.60;
    recife.y = 450;
    Airport portoAlegre = Airport('Porto Alegre');
    portoAlegre.x = 361.89;
    portoAlegre.y = 500.55;
    Airport brasilia = Airport('Brasilia');
    brasilia.x = 370.67;
    brasilia.y = 472.23;
    Airport rioDeJaneiro = Airport('Rio de Janeiro');
    rioDeJaneiro.x = 382.63;
    rioDeJaneiro.y = 482.90;
    Airport curitiba = Airport('Curitiba');
    curitiba.x = 365.84;
    curitiba.y = 489.57;
    Airport salvador = Airport('Salvador');
    salvador.x = 393.20;
    salvador.y = 458.63;
    Airport fortaleza = Airport('Fortaleza');
    fortaleza.x = 393.20;
    fortaleza.y = 440.42;
    Airport belem = Airport('Belem');
    belem.x = 369.70;
    belem.y = 435.00;
    Airport beloHorizonte = Airport('Belo Horizonte');
    beloHorizonte.x = 378.27;
    beloHorizonte.y = 476.52;
    Airport saoLuis = Airport('Sao Luis');
    saoLuis.x = 379.37;
    saoLuis.y = 438.44;
    Airport santarem = Airport('Santarem');
    santarem.x = 351.37;
    santarem.y = 437.00;
    /*
    Airport cuiaba = Airport('Cuiaba');
    cuiaba.x = 352.40;
    cuiaba.y = 472.23;
    */

    // Colombia
    Airport bogota = Airport('Bogota');
    bogota.x = 309.34;
    bogota.y = 419.00;
    Airport medelin = Airport('Medelin');
    medelin.x = 305.55;
    medelin.y = 411.92;
    Airport cali = Airport('Cali');
    cali.x = 302.16;
    cali.y = 423.60;
    Airport barranquilla = Airport('Barranquila');
    barranquilla.x = 306.72;
    barranquilla.y = 405.38;
    

    // Peru
    Airport lima = Airport('Lima');
    lima.x = 302.16;
    lima.y = 456.28;
    Airport cuzco = Airport('Cuzco');
    cuzco.x = 316.26;
    cuzco.y = 460.48;

    // Argentina
    Airport buenosAires = Airport('Buenos Aires');
    buenosAires.x = 344.72;
    buenosAires.y = 515.80;
    Airport cordoba = Airport('Cordoba');
    cordoba.x = 335.48;
    cordoba.y = 502.11;
    Airport mendoza = Airport('Mendoza');
    mendoza.x = 325.93;
    mendoza.y = 512.12;

    // Chile
    Airport santiago = Airport('Santiago');
    santiago.x = 315.50;
    santiago.y = 513.48;

    // Bolivia
    Airport santaCruz = Airport('Santa Cruz');
    santaCruz.x = 335.85;
    santaCruz.y = 474.62;
    Airport laPaz = Airport('La Paz');
    laPaz.x = 327.60;
    laPaz.y = 467.00;

    // Venezuela
    Airport caracas = Airport('Caracas');
    caracas.x = 326.48;
    caracas.y = 406.15;

    // Equador
    Airport guayaquil = Airport('Guayaquil');
    guayaquil.x = 296.16;
    guayaquil.y = 435.19;

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
    gameManager.addAirport(bogota);
    gameManager.addAirport(lima);
    gameManager.addAirport(buenosAires);
    gameManager.addAirport(santiago);
    gameManager.addAirport(beloHorizonte);
    gameManager.addAirport(medelin);
    gameManager.addAirport(santaCruz);
    gameManager.addAirport(cali);
    gameManager.addAirport(laPaz);
    gameManager.addAirport(cordoba);
    gameManager.addAirport(caracas);
    gameManager.addAirport(guayaquil);
    gameManager.addAirport(barranquilla);
    gameManager.addAirport(cuzco);
    gameManager.addAirport(mendoza);
    gameManager.addAirport(saoLuis);
    gameManager.addAirport(santarem);

    saoPaulo.unlock();
    curitiba.unlock();
    brasilia.unlock();
    rioDeJaneiro.unlock();

    gameManager.unlockedAirports.add(saoPaulo);
    gameManager.unlockedAirports.add(curitiba);
    gameManager.unlockedAirports.add(brasilia);
    gameManager.unlockedAirports.add(rioDeJaneiro);

    buildStore();
    

    timer = Timer.periodic(Duration(seconds: 60), (timer) { jobGenerator.generateRandomJob(); });

    if (await FileManager.saveFileExists()) {
      debugPrint('SAVE FILE EXISTS');
      await gameManager.loadGame();
      jobGenerator.generateJobs();
      return;
    }

    debugPrint('SAVE FILE NOT FOUND! GENERATING NEW GAME');

    Airplane pl1 = C172P('PL0001',saoPaulo);
    Airplane pl3 = C172C('PL0002',rioDeJaneiro);
    gameManager.addPlane(pl1);
    gameManager.addPlane(pl3);

    player.balance = 17000;
    jobGenerator.generateJobs();
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