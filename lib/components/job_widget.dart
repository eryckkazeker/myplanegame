import 'package:flutter/material.dart';
import 'package:pocketplanes2/enums/job_type.dart';
import 'package:pocketplanes2/model/job.dart';

class JobWidget extends StatelessWidget {
  final Function(Job) _clickCallBack;
  final Job _job;

  JobWidget(this._job, this._clickCallBack);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _clickCallBack(_job);
      },
      child: Card(
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
    );
  }
}
