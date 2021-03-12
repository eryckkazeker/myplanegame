import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pocketplanes2/components/page_footer.dart';
import 'package:pocketplanes2/enums/plane_status.dart';
import 'package:pocketplanes2/model/airplane.dart';
import 'package:pocketplanes2/model/player.dart';
import 'package:pocketplanes2/screens/airplane_screen.dart';
import 'package:pocketplanes2/util/economy_manager.dart';
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

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Airplane List'),
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
        body: ListView.builder(
            itemCount: gameManager.airplanes.length,
            itemBuilder: (context, index) {
              return AirplaneListItem(gameManager.airplanes[index], update);
            }),
        bottomNavigationBar: PageFooter(),
      ),
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
        if (_airplane.planeStatus == PlaneStatus.landed) {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AirplaneScreen(_airplane)))
              .then((value) => _updateCallback());
        }
      },
      child: Card(
        child: Container(
          color: (_airplane.planeStatus == PlaneStatus.landed)
              ? Colors.green[100]
              : Colors.red[200],
          child: Row(
            children: [
              Expanded(
                flex: 9,
                child: Column(
                  children: [
                    Icon(_airplane.planeStatus == PlaneStatus.landed
                        ? Icons.flight_land
                        : Icons.flight_takeoff),
                    Text('${_airplane.name} / ${_airplane.modelName}'),
                    Text(_airplane.planeStatus == PlaneStatus.landed
                        ? 'At ${_airplane.currentAirport.name}'
                        : 'Flying to ${_airplane.destinationList[0]?.name}'),
                    Text(
                        'Passengers: ${_airplane.passengerJobs.length} / ${_airplane.passengerCapacity}'),
                    Text(
                        'Cargo: ${_airplane.cargoJobs.length} / ${_airplane.cargoCapacity}'),
                    Text((_airplane.planeStatus == PlaneStatus.flying)
                        ? 'Arrives in ${_airplane.flightTime.toInt()}s'
                        : '')
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                    onTap: (_airplane.isFlying()) ? null :() {
                      sellAirplane(context, _airplane);
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: (_airplane.isFlying()) ? Colors.grey : Colors.green[900],
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        height: 40,
                        child: Icon(
                          Icons.monetization_on,
                          size: 16,
                          color: Colors.white,
                        )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void sellAirplane(BuildContext context, Airplane airplane) async {
    if (await checkAirplaneEmpty(context, airplane)) {
      var airplaneValue = EconomyManager.airplaneValue(airplane);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content:
                    Text('You will get \$$airplaneValue for this aircraft'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child: Text('SELL')),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: Text('CANCEL'))
                ],
              )).then((sell) {
        if (sell) {
          Player().addBalance(airplaneValue);
          GameManager().airplanes.remove(airplane);
        }
      });
    }
  }

  Future<bool> checkAirplaneEmpty(
      BuildContext context, Airplane airplane) async {
    if (airplane.cargoJobs.isNotEmpty || airplane.passengerJobs.isNotEmpty) {
      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text('Please, unload airplane before selling'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('OK'))
                ],
              ));
      return false;
    }
    return true;
  }
}
