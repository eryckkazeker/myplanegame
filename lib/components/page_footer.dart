import 'package:flutter/material.dart';
import 'package:pocketplanes2/model/player.dart';
import 'package:pocketplanes2/screens/airplane_list.dart';
import 'package:pocketplanes2/screens/map_screen.dart';

class PageFooter extends StatelessWidget {
  final Player player = Player();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                  child: RaisedButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => MapScreen()));
                },
                child: Text('Map'),
              )),
              Expanded(
                  child: RaisedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AirplaneListScreen()));
                },
                child: Text('Planes'),
              )),
              Expanded(
                  child: RaisedButton(
                onPressed: () {
                  
                },
                child: Text('Store'),
              ))
            ],
          ),
          Text('Balance: \$ ${player.balance}', textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
