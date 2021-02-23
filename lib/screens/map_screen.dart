import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pocketplanes2/components/map_component.dart';
import 'package:pocketplanes2/components/page_footer.dart';

class MapScreen extends StatefulWidget {

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
      });
     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('World Map')),
      body: MapComponent(null),
      bottomNavigationBar: PageFooter(),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
