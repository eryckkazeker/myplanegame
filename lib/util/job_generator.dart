import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:pocketplanes2/enums/job_type.dart';
import 'package:pocketplanes2/model/airport.dart';
import 'package:pocketplanes2/model/job.dart';
import 'package:pocketplanes2/util/economy_manager.dart';
import 'package:pocketplanes2/util/game_manager.dart';

class JobGenerator {

  GameManager _gameManager = GameManager();
  Random random = Random();

  void generateJobs() {
    dev.log('Generating jobs...');
    
    var airportList = _gameManager.unlockedAirports;
    airportList.forEach((airport) {
      dev.log('Current airport ${airport.name}');
      while(airport.currentJobs.length < GameManager.MAX_JOBS__PER_AIRPORT) {
        dev.log('Current jobs ${airport.currentJobs.length}');
        int index = random.nextInt(airportList.length);
        var destination = airportList[index];
        dev.log('Destination is ${destination.name}');
        if (destination == airport) {
          dev.log('Destination is the same as origin. Ignoring.');
          continue;
        }

        int jobTypeRandom = random.nextInt(2);
        JobType type = (jobTypeRandom == 1) ? JobType.passenger : JobType.cargo;
        var jobPrice = EconomyManager.jobPrice(airport, destination);
        Job job = Job(destination, type, jobPrice);

        dev.log('Adding job with value ${job.value}');
        airport.addJob(job);
      }
    });
  }

  void generateJobsBatch(int jobQuantity) {
    for (int i = 0; i < jobQuantity; i++) {
      generateRandomJob();
    }
  }

  void generateRandomJob() {
    bool jobGenerated = false;
    
    var airportList = _gameManager.unlockedAirports;
    Airport origin;
    Airport destination;
    int tries = 0;
    int maxRetries = 3;

    while(!jobGenerated && tries < maxRetries) {
      tries++;
      debugPrint('Starting job generation');
      origin = airportList[random.nextInt(airportList.length)];
      debugPrint('Origin is [${origin.name}]');
      if(origin.currentJobs.length == GameManager.MAX_JOBS__PER_AIRPORT) {
        debugPrint('Origin is full');
        debugPrint('Trying again.');
        continue;
      }
      
      destination = airportList[random.nextInt(airportList.length)];
      if (origin == destination) {
        debugPrint('Invalid destination.');
        debugPrint('Trying again.');
        continue;
      }

      int jobTypeRandom = random.nextInt(2);
      JobType type = (jobTypeRandom == 1) ? JobType.passenger : JobType.cargo;
      var jobPrice = EconomyManager.jobPrice(origin, destination);
      Job job = Job(destination, type, jobPrice);

      dev.log('Generated job from [${origin.name}] to [${destination.name}] job with value ${job.value}');
      origin.addJob(job);
      jobGenerated = true;
    }
  }

  static void generateJobsForAirport(Airport airport) {
    Random random = Random();
    var airportList = GameManager().unlockedAirports;
    while(airport.currentJobs.length < GameManager.MAX_JOBS__PER_AIRPORT) {
      var destination = airportList[random.nextInt(airportList.length)];
      if (airport == destination) {
        debugPrint('Invalid destination.');
        debugPrint('Trying again.');
        continue;
      }
      int jobTypeRandom = random.nextInt(2);
      JobType type = (jobTypeRandom == 1) ? JobType.passenger : JobType.cargo;
      var jobPrice = EconomyManager.jobPrice(airport, destination);
      Job job = Job(destination, type, jobPrice);

      dev.log('Generated job from [${airport.name}] to [${destination.name}] job with value ${job.value}');
      airport.addJob(job);
    }
  }
}