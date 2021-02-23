import 'package:flutter/material.dart';
import 'package:pocketplanes2/components/job/job_widget.dart';
import 'package:pocketplanes2/model/job.dart';

class JobListComponent extends StatefulWidget {
  final List<Job> _jobList;
  final Function(Job) _clickCallBack;

  JobListComponent(this._jobList, this._clickCallBack);

  @override
  _JobListComponentState createState() => _JobListComponentState();
}

class _JobListComponentState extends State<JobListComponent> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget._jobList.length,
        itemBuilder: (context, index) {
          return JobWidget(widget._jobList[index], widget._clickCallBack);
        });
  }
}
