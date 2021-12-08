import 'package:flutter/material.dart';

class MapEditorScreen extends StatefulWidget {
  @override
  _MapEditorScreenState createState() => _MapEditorScreenState();
}

class _MapEditorScreenState extends State<MapEditorScreen> {
  double x = 465.53;
  double y = 331.59;
  TransformationController controller = TransformationController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Center(
        child: InteractiveViewer(
          transformationController: controller,
          constrained: false,
          minScale: 1.0,
          maxScale: 10.0,
          child: Stack(
            children: [
              Container(
                child: Image.asset(
                  'assets/world_map.png',
                  scale: 3.0,
                ),
              ),
              Positioned(
                child: Container(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onVerticalDragUpdate: (details) {
                      setState(() {
                        y += details.delta.dy;
                        debugPrint('x: [$x] y: [$y]');
                        debugPrint('Controller: ${controller.value}');
                      });
                    },
                    onHorizontalDragUpdate: (details) {
                      setState(() {
                        x += details.delta.dx;
                        debugPrint('x: [$x] y: [$y]');
                        debugPrint('Controller: ${controller.value}');
                      });
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Icon(
                                Icons.house,
                                size: 3,
                              )),
                          Text(
                            'Airport',
                            style: TextStyle(
                                fontSize: 2,
                                color: Colors.blue,
                                backgroundColor: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                left: x,
                top: y,
              )
            ],
          ),
        ),
      ),
    );
  }
}
