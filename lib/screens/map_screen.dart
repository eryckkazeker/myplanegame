import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pocketplanes2/components/map_component.dart';
import 'package:pocketplanes2/components/page_footer.dart';
import 'package:pocketplanes2/model/airport.dart';
import 'package:pocketplanes2/screens/airport_screen.dart';

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
        appBar: AppBar(title: Text('World Map')),
        body: MapComponent(navigateToAirportScreen),
        bottomNavigationBar: PageFooter(),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void navigateToAirportScreen(BuildContext context, Airport airport) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AirportScreen(airport)));
  }
}
