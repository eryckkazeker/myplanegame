import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pocketplanes2/screens/map_screen.dart';
import 'package:pocketplanes2/util/game_generator.dart';
import 'package:pocketplanes2/util/game_manager.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  MyApp() {
    
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {

  @override
  void initState() {
    WidgetsBinding.instance.scheduleFrameCallback((timeStamp) {
      GameGenerator.generateGame();
    });
    
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Pocket Planes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MapScreen()
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      GameManager().saveGame();
    }
  }
}

