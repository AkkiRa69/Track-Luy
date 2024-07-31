import 'package:flutter/material.dart';
import 'package:flutter_arc_text/flutter_arc_text.dart';

class CircularTextWidget extends StatefulWidget {
  const CircularTextWidget({super.key});

  @override
  _CircularTextWidgetState createState() => _CircularTextWidgetState();
}

class _CircularTextWidgetState extends State<CircularTextWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      animationBehavior: AnimationBehavior.preserve,
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        alignment: Alignment.centerLeft,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 170,
              height: 170,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                ),
                shape: BoxShape.circle,
              ),
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _controller.value * 4 * 3.14,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: const ArcText(
                      radius: 55,
                      text: '•     MY PROJECTS     •     MY PROJECTS    ',
                      textStyle: TextStyle(fontSize: 18, color: Colors.white),
                      startAngle: -3.14 / 2,
                      startAngleAlignment: StartAngleAlignment.center,
                      placement: Placement.outside,
                      direction: Direction.clockwise,
                    ),
                  ),
                );
              },
            ),
            const Icon(
              Icons.arrow_downward,
              color: Colors.white,
              size: 35,
            ),
          ],
        ),
      ),
    );
  }
}
