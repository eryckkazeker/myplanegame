import 'package:flutter/material.dart';
import 'package:pocketplanes2/components/flight_planner_map.dart';
import 'package:pocketplanes2/components/page_footer.dart';
import 'package:pocketplanes2/model/airplane.dart';
import 'package:pocketplanes2/model/airport.dart';
import 'package:pocketplanes2/util/game_manager.dart';

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
    widget._airplane.destination = null;
    widget.gameManager.currentAirplane = widget._airplane;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flight Plan'),
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
            child: FlightPlannerMap(widget._airplane),
            /*
            child:ListView.builder(
                itemCount: widget.gameManager.airports.length,
                itemBuilder: (context, index) {
                  return (widget.gameManager.airports[index] ==
                          widget._airplane.currentAirport)
                      ? Container()
                      : Container(
                          height: 48,
                          child: GestureDetector(
                            onTap: () {
                              selectDestination(
                                  widget.gameManager.airports[index]);
                            },
                            child: Card(
                                child: Center(
                              child: Text(
                                widget.gameManager.airports[index].name,
                                textAlign: TextAlign.center,
                                textScaleFactor: 1.6,
                              ),
                            )),
                          ),
                        );
                }),*/
          ),
          /*
          Text('Selected Destination:'),
          Text(
              (widget._airplane.destination == null)
                  ? ''
                  : widget._airplane.destination.name,
              textScaleFactor: 2.0),
              */
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
                      if (widget._airplane.fly()) {
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

  void selectDestination(Airport airport) {
    if (airport == widget._airplane.currentAirport) {
      return;
    }

    widget._airplane.destination = airport;

    setState(() {});
  }
}
