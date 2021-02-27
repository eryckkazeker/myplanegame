import 'package:flutter/material.dart';
import 'package:pocketplanes2/enums/job_type.dart';
import 'package:pocketplanes2/model/airport.dart';
import 'package:pocketplanes2/model/job.dart';
import 'package:pocketplanes2/util/game_manager.dart';

class AirportScreen extends StatefulWidget {
  final Airport _airport;

  AirportScreen(this._airport);

  @override
  _AirportScreenState createState() => _AirportScreenState();
}

class _AirportScreenState extends State<AirportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._airport.name),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                GameManager().saveGame();
              },
              child: Icon(Icons.save),
            ),
          )
        ],
      ),
      body:  ListView.builder(
        itemCount: widget._airport.currentJobs.length,
        itemBuilder: (context, index) {
          return JobListItem(widget._airport.currentJobs[index]);
        })
        );
  }
}

class JobListItem extends StatelessWidget {

  final Job _job;

  JobListItem(this._job);

  @override
  Widget build(BuildContext context) {
    return Card(child: ListTile(
      leading: (_job.type == JobType.passenger) ? Icon(Icons.person) : Icon(Icons.sensor_window),
      title: Text('To ${_job.destination.name}'),
      subtitle: Text('\$${_job.value}'),
    ));
  }

  

}