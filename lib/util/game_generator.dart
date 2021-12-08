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

    // Panama
    Airport panama = Airport('Panama');
    panama.x = 295.38;
    panama.y = 407.68;

    // Costa Rica
    Airport sanJose = Airport('San Jose');
    sanJose.x = 284.72;
    sanJose.y = 405.38;

    // Honduras
    Airport tegucigalpa = Airport('Tegucigalpa');
    tegucigalpa.x = 279.29;
    tegucigalpa.y = 396.97;

    // Mexico
    Airport cancun = Airport('Cancun');
    cancun.x = 275.48;
    cancun.y = 379.34;
    Airport mexicoCity = Airport('Mexico City');
    mexicoCity.x = 248.16;
    mexicoCity.y = 382.73;
    Airport oaxaca = Airport('Oaxaca');
    oaxaca.x = 257.85;
    oaxaca.y = 389.64;
    Airport monterrey = Airport('Monterrey');
    monterrey.x = 246.99;
    monterrey.y = 367.27;

    // Cuba
    Airport havana = Airport('Havana');
    havana.x = 288.07;
    havana.y = 374.06;

    // United States
    Airport miami = Airport('Miami');
    miami.x = 292.66;
    miami.y = 366.16;
    Airport losAngeles = Airport('Los Angeles');
    losAngeles.x = 203.67;
    losAngeles.y = 344.65;
    Airport sanFrancisco = Airport('San Francisco');
    sanFrancisco.x = 194.15;
    sanFrancisco.y = 335.33;
    Airport lasVegas = Airport('Las Vegas');
    lasVegas.x = 211.07;
    lasVegas.y = 337.54;
    Airport phoenix = Airport('Phoenix');
    phoenix.x = 218.08;
    phoenix.y = 346.57;
    Airport denver = Airport('Denver');
    denver.x = 230.36;
    denver.y = 332.51;
    Airport houston = Airport('Houston');
    houston.x = 257.20;
    houston.y = 355.64;
    Airport dallas = Airport('Dallas');
    dallas.x = 252.21;
    dallas.y = 345.73;
    Airport oklahoma = Airport('Oklahoma');
    oklahoma.x = 247.11;
    oklahoma.y = 337.68;
    Airport kansasCity = Airport('Kansas City');
    kansasCity.x = 259.14;
    kansasCity.y = 331.64;
    Airport chicago = Airport('Chicago');
    chicago.x = 276.30;
    chicago.y = 323.66;
    Airport atlanta = Airport('Atlanta');
    atlanta.x = 282.06;
    atlanta.y = 342.62;
    Airport nashville = Airport('Nashville');
    nashville.x = 276.90;
    nashville.y = 335.86;
    Airport washington = Airport('Washington');
    washington.x = 301.68;
    washington.y = 331.32;
    Airport newYork = Airport('New York');
    newYork.x = 308.31;
    newYork.y = 325.84;
    Airport portland = Airport('Portland');
    portland.x = 191.71;
    portland.y = 312.48;

    //Canada
    Airport toronto = Airport('Toronto');
    toronto.x = 297.86;
    toronto.y = 317.25;
    Airport montreal = Airport('Montreal');
    montreal.x = 308.38;
    montreal.y = 311.60;
    Airport vancouver = Airport('Vancouver');
    vancouver.x = 192.98;
    vancouver.y = 301.38;
    Airport calgary = Airport('Calgary');
    calgary.x = 219.06;
    calgary.y = 297.18;
    Airport edmonton = Airport('Edmonton');
    edmonton.x = 224.96;
    edmonton.y = 287.31;
    Airport kamloops = Airport('Kamloops');
    kamloops.x = 204.24;
    kamloops.y = 298.45;

    //Portugal
    Airport lisbon = Airport('Lisbon');
    lisbon.x = 465.53;
    lisbon.y = 331.59;

    //Spain
    Airport madrid = Airport('Madrid');
    madrid.x = 474.73;
    madrid.y = 327.89;
    Airport barcelona = Airport('Barcelona');
    barcelona.x = 490.61;
    barcelona.y = 324.18;
    //England
    Airport london = Airport('London');
    london.x = 485.24;
    london.y = 294.22;
    //France
    Airport paris = Airport('Paris');
    paris.x = 492.08;
    paris.y = 304.73;
    //Germany
    Airport berlin = Airport('Berlin');
    berlin.x = 518.73;
    berlin.y = 293.81;
    //Denmark
    Airport copenhage = Airport('Copenhage');
    copenhage.x = 514.87;
    copenhage.y = 282.52;
    //Italy
    Airport rome = Airport('Rome');
    rome.x = 516.62;
    rome.y = 323.38;
    //Sweden
    Airport stockholm = Airport('Stockholm');
    stockholm.x = 529.19;
    stockholm.y = 267.65;
    //Norway
    Airport oslo = Airport('Oslo');
    oslo.x = 510.50;
    oslo.y = 266.85;
    //Netherlands
    Airport amsterdam = Airport('Amsterdam');
    amsterdam.x = 499.02;
    amsterdam.y = 291.14;
    //Ireland
    Airport dublin = Airport('Dublin');
    dublin.x = 469.94;
    dublin.y = 289.75;
    //Switzerland
    Airport zurich = Airport('Zurich');
    zurich.x = 506.95;
    zurich.y = 310.21;
    //Finland
    Airport helsinki = Airport('Helsinki');
    helsinki.x = 545.14;
    helsinki.y = 264.46;
    //Belarus
    Airport minsk = Airport('Minsk');
    minsk.x = 549.88;
    minsk.y = 287.49;
    //Poland
    Airport warsaw = Airport('Warsaw');
    warsaw.x = 536.95;
    warsaw.y = 292.57;
    //Czech Republic
    Airport prague = Airport('Prague');
    prague.x = 521.20;
    prague.y = 299.26;
    //Austria
    Airport viena = Airport('Viena');
    viena.x = 526.93;
    viena.y = 304.13;
    //Hungary
    Airport budapest = Airport('Budapest');
    budapest.x = 533.60;
    budapest.y = 309.45;
    //Ukraine
    Airport kiev = Airport('Kiev');
    kiev.x = 559.93;
    kiev.y = 296.87;
    //Greece
    Airport athens = Airport('Athens');
    athens.x = 543.31;
    athens.y = 334.95;
    //Turkey
    Airport istanbul = Airport('Istanbul');
    istanbul.x = 556.18;
    istanbul.y = 326.12;
    Airport ankara = Airport('Ankara');
    ankara.x = 564.40;
    ankara.y = 330.26;
    //Syria
    Airport damascus = Airport('Damascus');
    damascus.x = 575.48;
    damascus.y = 346.90;


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
    //gameManager.addAirport(medelin);
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
    //gameManager.addAirport(panama);
    //gameManager.addAirport(sanJose);
    gameManager.addAirport(tegucigalpa);
    gameManager.addAirport(cancun);
    gameManager.addAirport(mexicoCity);
    gameManager.addAirport(havana);
    gameManager.addAirport(miami);
    gameManager.addAirport(oaxaca);
    gameManager.addAirport(losAngeles);
    gameManager.addAirport(sanFrancisco);
    gameManager.addAirport(lasVegas);
    gameManager.addAirport(phoenix);
    gameManager.addAirport(denver);
    gameManager.addAirport(houston);
    gameManager.addAirport(dallas);
    //gameManager.addAirport(monterrey);
    //gameManager.addAirport(oklahoma);
    gameManager.addAirport(kansasCity);
    gameManager.addAirport(chicago);
    gameManager.addAirport(atlanta);
    gameManager.addAirport(nashville);
    gameManager.addAirport(washington);
    gameManager.addAirport(newYork);
    gameManager.addAirport(toronto);
    gameManager.addAirport(montreal);
    gameManager.addAirport(portland);
    gameManager.addAirport(vancouver);
    gameManager.addAirport(calgary);
    gameManager.addAirport(edmonton);
    gameManager.addAirport(kamloops);
    gameManager.addAirport(lisbon);
    gameManager.addAirport(madrid);
    gameManager.addAirport(paris);
    gameManager.addAirport(london);
    gameManager.addAirport(barcelona);
    gameManager.addAirport(berlin);
    gameManager.addAirport(copenhage);
    gameManager.addAirport(rome);
    gameManager.addAirport(stockholm);
    gameManager.addAirport(oslo);
    gameManager.addAirport(amsterdam);
    gameManager.addAirport(dublin);
    gameManager.addAirport(zurich);
    gameManager.addAirport(helsinki);
    gameManager.addAirport(minsk);
    gameManager.addAirport(warsaw);
    gameManager.addAirport(prague);
    gameManager.addAirport(viena);
    gameManager.addAirport(budapest);
    gameManager.addAirport(kiev);
    gameManager.addAirport(athens);
    gameManager.addAirport(istanbul);
    gameManager.addAirport(ankara);
    gameManager.addAirport(damascus);

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

/*
    if (await FileManager.saveFileExists()) {
      debugPrint('SAVE FILE EXISTS');
      await gameManager.loadGame();
      jobGenerator.generateJobs();
      return;
    }
*/
    debugPrint('SAVE FILE NOT FOUND! GENERATING NEW GAME');

    Airplane pl1 = C172P('PL0001',athens);
    Airplane pl3 = C208C('PL0002',rioDeJaneiro);
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