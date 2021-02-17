import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pocketplanes2/components/page_footer.dart';
import 'package:pocketplanes2/enums/plane_status.dart';
import 'package:pocketplanes2/model/airplane.dart';
import 'package:pocketplanes2/model/player.dart';
import 'package:pocketplanes2/screens/airplane_screen.dart';
import 'package:pocketplanes2/util/game_manager.dart';

class AirplaneListScreen extends StatefulWidget {
  @override
  _AirplaneListScreenState createState() => _AirplaneListScreenState();
}

class _AirplaneListScreenState extends State<AirplaneListScreen> {
  var gameManager = GameManager();
  var player = Player();
  Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) { setState(() {
      
    }); });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Airplane List'),
      ),
      body: ListView.builder(
          itemCount: gameManager.airplanes.length,
          itemBuilder: (context, index) {
            return AirplaneListItem(gameManager.airplanes[index], update);
          }),
          bottomNavigationBar: PageFooter(),
    );
  }

  void update() {
    setState(() {});
  }
}

class AirplaneListItem extends StatelessWidget {
  final Airplane _airplane;
  final Function _updateCallback;

  AirplaneListItem(this._airplane, this._updateCallback);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(_airplane.planeStatus == PlaneStatus.landed) {
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => AirplaneScreen(_airplane)))
            .then((value) => _updateCallback());
        }
      },
      child: Card(
        child: Container(
          color: (_airplane.planeStatus == PlaneStatus.landed) ? Colors.green[100] : Colors.red[200],
          child: Column(
            children: [
              Icon(_airplane.planeStatus == PlaneStatus.landed ? Icons.flight_land : Icons.flight_takeoff),
              Text('${_airplane.name}'),
              Text(_airplane.planeStatus == PlaneStatus.landed ? 'At ${_airplane.currentAirport.name}' :
              'Flying to ${_airplane.destination.name}'),
              Text(
                  'Passengers: ${_airplane.passengerJobs.length} / ${_airplane.passengerCapacity}'),
              Text(
                  'Cargo: ${_airplane.cargoJobs.length} / ${_airplane.cargoCapacity}')
            ],
          ),
        ),
      ),
    );
  }
}
