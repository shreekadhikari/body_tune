import 'dart:async';
import 'dart:math' as math;

import 'package:body_tune/helper.dart';
import 'package:body_tune/mp5_apnea.dart';
import 'package:flutter/material.dart';


class Mp4GuidedBreathing extends StatefulWidget {
  @override
  _Mp4GuidedBreathingState createState() => _Mp4GuidedBreathingState();
}

class _Mp4GuidedBreathingState extends State<Mp4GuidedBreathing>
    with SingleTickerProviderStateMixin {
  Timer _timer;
  _Mp4GuidedBreathingState() {
    _timer = Timer(const Duration(milliseconds: 5000), () async {
      // if (userString == null) {
      if (true) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Mp5Apnea()),
        );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Normal Breathing',
            textAlign: TextAlign.center,
            // style: textHeading1(context),
          ),
          bottomOpacity: 0.0,
          automaticallyImplyLeading: false),
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
          Spacer(),
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
          Spacer(),
          Container(
              child: Text(
                'Note: Please breathe in sync with the breathing bubble for 10 secs',
                //style: textBody1(context),
              )),
          Spacer(),
          // RaisedButton(
          //   splashColor: Theme.of(context).primaryColor,
          //   child: Text(
          //     'Next',
          //     style: TextStyle(
          //       color: Colors.white,
          //     ),
          //   ),
          //   // color: Theme.of(context).accentColor,
          //   onPressed: () async {
          //     // if (_formKey.currentState.validate()) {
          //     if (true) {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => Mp5Apnea()),
          //       );
          //     }
          //   },
          // )
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
