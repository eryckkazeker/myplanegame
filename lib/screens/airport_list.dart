import 'package:flutter/material.dart';
import 'package:pocketplanes2/model/airport.dart';
import 'package:pocketplanes2/screens/airport_screen.dart';
import 'package:pocketplanes2/util/game_manager.dart';

class AirportListScreen extends StatefulWidget {
  @override
  _AirportListScreenState createState() => _AirportListScreenState();
}

class _AirportListScreenState extends State<AirportListScreen> {
  var gameManager = GameManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Airport List'),
      ),
      body: ListView.builder(
          itemCount: gameManager.airports.length,
          itemBuilder: (context, index) {
            return AirportListItem(gameManager.airports[index]);
          }),
    );
  }
}

class AirportListItem extends StatelessWidget {
  final Airport _airport;

  AirportListItem(this._airport);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.house),
        title: Text(_airport.name),
        subtitle:
            Text('${_airport.layovers.length} / ${_airport.layoverCapacity}'),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AirportScreen(_airport)));
        },
      ),
    );
  }
}
