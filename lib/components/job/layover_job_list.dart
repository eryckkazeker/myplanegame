import 'package:flutter/material.dart';
import 'package:pocketplanes2/components/empty_list_space.dart';
import 'package:pocketplanes2/components/job/layover_job_widget.dart';
import 'package:pocketplanes2/model/airport.dart';
import 'package:pocketplanes2/model/job.dart';
import 'package:pocketplanes2/model/player.dart';
import 'package:pocketplanes2/util/economy_manager.dart';

class LayoverJobListComponent extends StatefulWidget {
  final Airport _airport;
  final Function(Job) _clickCallBack;

  LayoverJobListComponent(this._airport, this._clickCallBack);

  @override
  _LayoverJobListComponentState createState() => _LayoverJobListComponentState();
}

class _LayoverJobListComponentState extends State<LayoverJobListComponent> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget._airport.layoverCapacity+1,
        itemBuilder: (context, index) {
          if(index < widget._airport.layovers.length) {
            return LayoverJobWidget(widget._airport.layovers[index], widget._clickCallBack);
          }
          return (index < widget._airport.layoverCapacity) ?
            EmptyListSpace() :
            AirportUpgradeListItem(widget._airport);
        });
  }
}

class AirportUpgradeListItem extends StatelessWidget {
  final Airport _airport;

  AirportUpgradeListItem(this._airport);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ElevatedButton(
        child: Icon(Icons.add),
        onPressed: (Player().balance < EconomyManager.layoverUpgradePrice(_airport)) ?
        null :
        () {
          debugPrint('Upgrading airport ${_airport.name}');
          var upgradePrice = EconomyManager.layoverUpgradePrice(_airport);
          showDialog(context: context, builder: (context) => AlertDialog(
            content: (Text('That will cost \$ $upgradePrice. Are you sure?')),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context, false), child: Text('NO')),
              TextButton(onPressed: () => Navigator.pop(context, true), child: Text('YES')),
            ],),
          ).then((value) {
            if (value) {
              Player().pay(EconomyManager.layoverUpgradePrice(_airport));
            _airport.upgradeLayoverCapacity();
            }
          });
        }),
    );
  }
}
