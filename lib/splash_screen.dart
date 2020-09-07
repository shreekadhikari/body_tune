import 'dart:async';

import 'package:body_tune/register_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ContentMain();
  }
}

class _ContentMain extends State<SplashScreen> {
  Timer _timer;

  _ContentMain() {
    _timer = new Timer(const Duration(milliseconds: 1500), () {
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterPage()),
        );
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(20.0),
            child: Image.asset('assets/images/logo_body_tune.jpeg'),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(24.0, 64.0, 24.0, 24.0),
            child: Text(
              'Welcome!',
              style: TextStyle(
                  fontSize: 48,
                  color: Colors.grey[600],
                  fontFamily: 'Arial',
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
