import 'dart:async';
import 'dart:math' as math;

import 'package:body_tune/helper.dart';
import 'package:body_tune/mp4_swallowing.dart';
import 'package:body_tune/mp2_apnea.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mp3GuidedBreathing extends StatefulWidget {
  @override
  _Mp3GuidedBreathingState createState() => _Mp3GuidedBreathingState();
}

class _Mp3GuidedBreathingState extends State<Mp3GuidedBreathing>
    with SingleTickerProviderStateMixin {
  int time;
  SharedPreferences preferences;

  _Mp3GuidedBreathingState() {
    getSharedPreferences();
  }

  getSharedPreferences() async {
    this.preferences = await SharedPreferences.getInstance();
    time = int.parse(preferences.getString(SPText().guidedBreathing));
    Timer(Duration(seconds: time), () async {
      // if (userString == null) {
      if (true) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Mp4Swallowing()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
              title: Text(
                'Guided Breathing',
                textAlign: TextAlign.center,
                // style: textHeading1(context),
              ),
              bottomOpacity: 0.0,
              automaticallyImplyLeading: false),
          backgroundColor: CustomColor().alternateBackground,
          body: SizedBox.expand(child: CupertinoBreathe()),
        ),
        onWillPop: () async {
          return false;
        });
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
      duration: const Duration(seconds: 3),
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
    return Container(
      color: CustomColor().alternateBackground,
      padding: EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Spacer(flex: 2),
          Center(
            child: AspectRatio(
              aspectRatio: 1.0,
              child: CustomPaint(
                painter: _BreathePainter(
                    CurvedAnimation(parent: _controller, curve: Curves.ease)),
                size: Size.infinite,
              ),
            ),
          ),
          Spacer(flex: 2),
          Container(
              alignment: Alignment.center,
              child: Text(
                'ACTION: PLEASE BREATHE IN SYNC WITH THE GUIDING BUBBLE',
                //style: textBody1(context),
              )),
          Spacer(
            flex: 1,
          ),
        ],
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
