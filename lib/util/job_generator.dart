import 'dart:developer' as dev;
import 'dart:math';

import 'package:pocketplanes2/enums/job_type.dart';
import 'package:pocketplanes2/model/job.dart';
import 'package:pocketplanes2/util/game_manager.dart';

class JobGenerator {
  GameManager _gameManager = GameManager();

  void generateJobs() {
    dev.log('Generating jobs...');
    Random random = Random();
    var airportList = _gameManager.airports;
    airportList.forEach((airport) {
      dev.log('Current airport ${airport.name}');
      while(airport.currentJobs.length < GameManager.MAX_JOBS__PER_AIRPORT) {
        dev.log('Current jobs ${airport.currentJobs.length}');
        int index = random.nextInt(airportList.length);
        var a = airportList[index];
        dev.log('Destination is ${a.name}');
        if (a == airport) {
          dev.log('Destination is the same as origin. Ignoring.');
          continue;
        }

        int jobTypeRandom = random.nextInt(2);
        JobType type = (jobTypeRandom == 1) ? JobType.passenger : JobType.cargo;
        Job job = Job(a, type, random.nextInt(1000));

        dev.log('Adding job with value ${job.value}');
        airport.addJob(job);
      }

      Future.delayed(Duration(minutes: 1), () {generateJobs();});
    });
  }
}