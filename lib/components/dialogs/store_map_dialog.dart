import 'package:flutter/material.dart';
import 'package:pocketplanes2/components/map_component.dart';
import 'package:pocketplanes2/model/airport.dart';

class StoreMapDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        elevation: 5,
        shape: ContinuousRectangleBorder(),
        backgroundColor: Colors.white,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text('Where do you want to store?'),
          Container(height: 500, child: MapComponent(selectAirport))
        ]));
  }

  void selectAirport(BuildContext context, Airport airport) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text(
                  'Are you sure you want to place the airplane at ${airport.name}?'),
              actions: [
                TextButton(child: Text('YES'), onPressed: () => Navigator.pop(context, true)),
                TextButton(onPressed: () => Navigator.pop(context, false), child: Text('NO'))
              ],
            )).then((value) => {
              if (value) {
                Navigator.pop(context, airport)
              }
            });
  }
}
