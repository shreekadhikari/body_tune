import 'dart:math' as math;

import 'package:body_tune/helper.dart';
import 'package:flutter/material.dart';

// void main() {
//   runApp(
//     MaterialApp(
//       home: Home(),
//       debugShowCheckedModeBanner: false,
//     ),
//   );
// }

class MeasurementPage4 extends StatefulWidget {
  @override
  _MeasurementPage4State createState() => _MeasurementPage4State();
}

class _MeasurementPage4State extends State<MeasurementPage4>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guided Breathing'),
      ),
      backgroundColor: CustomColor().alternateBackground,
      body: SizedBox.expand(child: CupertinoBreathe()),
    );
  }
}

class CupertinoBreathe extends StatefulWidget {
  @override
  _CupertinoBreatheState createState() => _CupertinoBreatheState();
}

class _CupertinoBreatheState extends State<CupertinoBreathe>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: CustomPaint(
          painter: _BreathePainter(
              CurvedAnimation(parent: _controller, curve: Curves.ease)),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class _BreathePainter extends CustomPainter {
  _BreathePainter(
    this.animation, {
    this.count = 15,
    // Color color = const Color(0xFF61bea2),
    Color color = const Color(0xFF769976),
  })  : circlePaint = Paint()
          ..color = color
          ..blendMode = BlendMode.modulate,
        super(repaint: animation);

  final Animation<double> animation;
  final int count;
  final Paint circlePaint;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (size.shortestSide * 0.1) * animation.value;
    for (int index = 0; index < count; index++) {
      final indexAngle = (index * math.pi / count * 2);
      final angle = indexAngle + (math.pi * 1.5 * animation.value);
      final offset = Offset(math.sin(angle), math.cos(angle)) * radius * 0.985;
      canvas.drawCircle(center + offset * animation.value, radius, circlePaint);
    }
  }

  @override
  bool shouldRepaint(_BreathePainter oldDelegate) =>
      animation != oldDelegate.animation;
}
