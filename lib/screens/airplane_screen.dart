import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pocketplanes2/components/job_list.dart';
import 'package:pocketplanes2/components/page_footer.dart';
import 'package:pocketplanes2/model/airplane.dart';
import 'package:pocketplanes2/model/job.dart';
import 'package:pocketplanes2/screens/flight_planner.dart';

class AirplaneScreen extends StatefulWidget {
  final Airplane _airplane;

  AirplaneScreen(this._airplane);

  @override
  _AirplaneScreenState createState() => _AirplaneScreenState();
}

class _AirplaneScreenState extends State<AirplaneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._airplane.name),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
            child: Text(
                'Current airport: ${widget._airplane.currentAirport.name}'),
          ),
          Text('Boarded Jobs:'),
          Expanded(
              child: Row(
            children: [
              Expanded(
                  child: Column(
                children: [
                  Text('Passengers:'),
                  Expanded(
                      child: JobListComponent(
                          widget._airplane.passengerJobs, unboardJob))
                ],
              )),
              Expanded(
                  child: Column(
                children: [
                  Text('Cargo:'),
                  Expanded(
                      child: JobListComponent(
                          widget._airplane.cargoJobs, unboardJob))
                ],
              ))
            ],
          )),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text('Available Jobs:'),
                      Expanded(
                        child: JobListComponent(
                            widget._airplane.currentAirport.currentJobs,
                            boardJob),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text('Layover Jobs:'),
                      Expanded(
                        child: JobListComponent(
                            widget._airplane.currentAirport.layovers, boardLayover),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: SizedBox(
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              FlightPlannerScreen(widget._airplane)));
                },
                child: Text('FLIGHT PLAN'),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: PageFooter(),
    );
  }

  void boardJob(Job job) {
    log('Job selected: ${job.destination.name}');
    if (widget._airplane.boardJob(job)) {
      widget._airplane.currentAirport.currentJobs.remove(job);
      log('Airplane jobs: ${widget._airplane.totalJobs()}');
      log('Airport jobs: ${widget._airplane.currentAirport.currentJobs.length}');
    }

    setState(() {});
  }

  void boardLayover(Job job) {
    if (widget._airplane.boardJob(job)) {
      widget._airplane.currentAirport.layovers.remove(job);
      log('Airplane jobs: ${widget._airplane.totalJobs()}');
      log('Airport jobs: ${widget._airplane.currentAirport.currentJobs.length}');
    }

    setState(() {});
  }

  void unboardJob(Job job) {
    if (widget._airplane.currentAirport.unboardJob(job)) {
      widget._airplane.unboardJob(job);
    }

    setState(() {});
  }
}
