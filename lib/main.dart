import 'package:flutter/material.dart';
import 'package:pocketplanes2/screens/map_screen.dart';
import 'package:pocketplanes2/util/game_generator.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  MyApp() {
    GameGenerator.generateGame();
  }

  // This widget is the root of your application.
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
}

