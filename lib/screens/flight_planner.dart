import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pocketplanes2/components/flight_planner_map.dart';
import 'package:pocketplanes2/components/page_footer.dart';
import 'package:pocketplanes2/model/airplane.dart';
import 'package:pocketplanes2/model/airport.dart';
import 'package:pocketplanes2/util/game_manager.dart';
import 'package:pocketplanes2/util/geography_helper.dart';

class FlightPlannerScreen extends StatefulWidget {
  final GameManager gameManager = GameManager();
  final Airplane _airplane;

  FlightPlannerScreen(this._airplane);

  @override
  _FlightPlannerScreenState createState() => _FlightPlannerScreenState();
}

class _FlightPlannerScreenState extends State<FlightPlannerScreen> {

  @override
  void initState() {
    widget._airplane.destinationList = List<Airport>();
    widget.gameManager.currentAirplane = widget._airplane;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flight Plan'),
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
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(padding: EdgeInsets.only(top: 16.0)),
          Text('From:'),
          Text(
            widget._airplane.currentAirport.name,
            textScaleFactor: 2.0,
          ),
          Padding(padding: EdgeInsets.only(top: 16.0)),
          Text('To:'),
          Expanded(
            flex: 10,
            child: FlightPlannerMap(widget._airplane, selectDestination),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0, left: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: () {
                      if (widget._airplane.canFly()) {
                        widget._airplane.fly();
                        //TODO change to method that pops other containers
                        Navigator.pop(context);
                        Navigator.pop(context);
                      } else {
                        //TODO display error message
                      }
                    },
                    child: Text('FLY!'),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: PageFooter(),
    );
  }

  @override
  void dispose() {
    widget.gameManager.currentAirplane = null;
    super.dispose();
  }

  void selectDestination(BuildContext context, Airport airport) {
    log('selected destination ${airport.name}');
    var lastAirport = (widget._airplane.destinationList.length == 0) ?
      widget._airplane.currentAirport :
      widget._airplane.destinationList.last;
      
    if (airport == lastAirport) {
      widget._airplane.destinationList.removeLast();
      return;
    }

    if(!GeographyHelper.isInRange(airport, lastAirport, widget._airplane)) {
      return;
    }

    widget._airplane.destinationList.add(airport);

    setState(() {
      
    });
  }
}
