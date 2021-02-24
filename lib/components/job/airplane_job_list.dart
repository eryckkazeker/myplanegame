import 'package:flutter/material.dart';
import 'package:pocketplanes2/components/empty_list_space.dart';
import 'package:pocketplanes2/components/job/job_widget.dart';
import 'package:pocketplanes2/model/job.dart';

class AirplaneJobListComponent extends StatefulWidget {
  final List<Job> _jobList;
  final int _capacity;
  final Function(Job) _clickCallBack;

  AirplaneJobListComponent(this._jobList, this._capacity, this._clickCallBack);

  @override
  _AirplaneJobListComponentState createState() => _AirplaneJobListComponentState();
}

class _AirplaneJobListComponentState extends State<AirplaneJobListComponent> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget._capacity,
        itemBuilder: (context, index) {
          return (index < widget._jobList.length) ?
          JobWidget(widget._jobList[index], widget._clickCallBack) :
          EmptyListSpace();
        });
  }
}