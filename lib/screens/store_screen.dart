import 'package:flutter/material.dart';
import 'package:pocketplanes2/components/dialogs/store_map_dialog.dart';
import 'package:pocketplanes2/components/page_footer.dart';
import 'package:pocketplanes2/model/airplane.dart';
import 'package:pocketplanes2/model/airport.dart';
import 'package:pocketplanes2/model/player.dart';
import 'package:pocketplanes2/util/game_manager.dart';

class StoreScreen extends StatefulWidget {
  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {

  var gameManager = GameManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Store'),),
      body: ListView.builder(
        itemCount: gameManager.store.length,
        itemBuilder: (context, index) {
          return StoreAirplaneItem(gameManager.store[index], buyAirplane);
        }),
      bottomNavigationBar: PageFooter(),
    );
  }

  void buyAirplane(Airplane airplane, Airport airport) {
    if (Player().balance < airplane.price) {
      return;
    }

    Player().pay(airplane.price);
    airplane.currentAirport = airport;
    airplane.name = 'PL${(gameManager.airplanes.length+1).toString().padLeft(4,'0')}';
    gameManager.addPlane(airplane);

    setState(() {
      
    });

  }
}

class StoreAirplaneItem extends StatefulWidget {

  final Airplane _airplane;
  final Function _clickCallback;

  StoreAirplaneItem(this._airplane, this._clickCallback);

  @override
  _StoreAirplaneItemState createState() => _StoreAirplaneItemState();
}

class _StoreAirplaneItemState extends State<StoreAirplaneItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Expanded(child: Column(children: [
            Text(widget._airplane.modelName),
            Text('Passengers: ${widget._airplane.passengerCapacity}'),
            Text('Cargo: ${widget._airplane.cargoCapacity}')
          ],)),
          Expanded(child: Text('\$ ${widget._airplane.price}')),
          Expanded(
                      child: RaisedButton(child: Text('BUY'),
            onPressed: (Player().balance < widget._airplane.price) ? null :
            () {
              showDialog(context: context, builder: (context) => StoreMapDialog()).then((selectedAirport) => {
                widget._clickCallback(widget._airplane, selectedAirport)
              });
            }
            ),
          )
        ],
      ),
    );
  }
}