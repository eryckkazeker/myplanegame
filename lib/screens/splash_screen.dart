import 'package:flutter/material.dart';
import 'package:pocketplanes2/screens/map_screen.dart';
import 'package:pocketplanes2/util/game_generator.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.scheduleFrameCallback((timeStamp) async {
      await GameGenerator.generateGame();
      Future.delayed(Duration(seconds: 1), () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MapScreen()));
      });
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              Text('Loading game...')
            ],
          ),
        ),
      ),
    );
  }
}