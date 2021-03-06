import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pocketplanes2/components/map_component.dart';
import 'package:pocketplanes2/components/page_footer.dart';
import 'package:pocketplanes2/model/airport.dart';
import 'package:pocketplanes2/model/player.dart';
import 'package:pocketplanes2/screens/airport_screen.dart';
import 'package:pocketplanes2/util/economy_manager.dart';
import 'package:pocketplanes2/util/game_manager.dart';
import 'package:pocketplanes2/util/job_generator.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
          child: Scaffold(
        appBar: AppBar(title: Text('World Map'),
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
        ],),
        body: MapComponent(airportSelected),
        bottomNavigationBar: PageFooter(),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void airportSelected(BuildContext context, Airport airport) {
    if(!airport.locked) {
      navigateToAirportScreen(context, airport);
    } else {
      if(Player().balance < EconomyManager.airportPrice()) {
        showDialog(context: context, builder: (context) => AlertDialog(
        content: Text('The price to unlock is \$${EconomyManager.airportPrice()}'),
        actions: [
          TextButton(onPressed: () {Navigator.pop(context);}, child: Text('OK')),
        ],
      ));
      } else {
        showDialog(context: context, builder: (context) => AlertDialog(
        content: Text('Unlock ${airport.name} for \$ ${EconomyManager.airportPrice()}?'),
        actions: [
          TextButton(onPressed: () {Navigator.pop(context, true);}, child: Text('YES')),
          TextButton(onPressed: () {Navigator.pop(context, false);}, child: Text('NO'))
        ],
      ))
      .then((buyAirport) {
        if (buyAirport) {
          Player().pay(EconomyManager.airportPrice());
          airport.unlock();
          GameManager().unlockedAirports.add(airport);
          JobGenerator.generateJobsForAirport(airport);
          setState(() {
            
          });
        }
      });
      }
      
    }
  }

  void navigateToAirportScreen(BuildContext context, Airport airport) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AirportScreen(airport)));
  }
}
