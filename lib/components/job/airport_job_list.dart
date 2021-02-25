import 'package:flutter/material.dart';
import 'package:pocketplanes2/components/job/job_widget.dart';
import 'package:pocketplanes2/model/job.dart';

class AirportJobListComponent extends StatefulWidget {
  final List<Job> _jobList;
  final Function(Job) _clickCallBack;

  AirportJobListComponent(this._jobList, this._clickCallBack);

  @override
  _AirportJobListComponentState createState() => _AirportJobListComponentState();
}

class _AirportJobListComponentState extends State<AirportJobListComponent> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget._jobList.length,
        itemBuilder: (context, index) {
          return JobWidget(widget._jobList[index], widget._clickCallBack);
        });
  }
}
