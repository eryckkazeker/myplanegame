import 'package:flutter/material.dart';
import 'package:pocketplanes2/model/player.dart';
import 'package:pocketplanes2/screens/airplane_list.dart';
import 'package:pocketplanes2/screens/map_screen.dart';
import 'package:pocketplanes2/screens/store_screen.dart';

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
                  child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) => MapScreen()),
                      (route) => false);
                },
                child: Text('Map'),
              )),
              Expanded(
                  child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) => AirplaneListScreen()),
                      (route) => false);
                },
                child: Text('Planes'),
              )),
              Expanded(
                  child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) => StoreScreen()),
                      (route) => false);
                },
                child: Text('Store'),
              ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Balance: \$ ${player.balance}', textAlign: TextAlign.center),
              Text((player.nextTripProfit > 0) ? ' + \$${player.nextTripProfit}' : '', style: TextStyle(color: Colors.green)),
              Text((player.nextTripProfit < 0) ? ' - \$${player.nextTripProfit.abs()}' : '', style: TextStyle(color: Colors.red))
            ],
          ),
          
        ],
      ),
    );
  }
}
