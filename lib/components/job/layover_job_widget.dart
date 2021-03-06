import 'package:flutter/material.dart';
import 'package:pocketplanes2/enums/job_type.dart';
import 'package:pocketplanes2/model/job.dart';

class LayoverJobWidget extends StatelessWidget {
  final Function(Job) _clickCallBack;
  final Job _job;

  LayoverJobWidget(this._job, this._clickCallBack);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _clickCallBack(_job);
      },
      child: Card(
        child: Row(
          children: [
            Expanded(
              flex: 8,
              child: Column(
                children: [
                  Icon((_job.type == JobType.passenger)
                      ? Icons.person
                      : Icons.sensor_window),
                  Text(_job.destination.name),
                  Text('\$${_job.value.toString()}')
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                  onTap: () {
                    _job.delete();
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      height: 40,
                      child: Icon(
                        Icons.delete,
                        size: 16,
                        color: Colors.white,
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
