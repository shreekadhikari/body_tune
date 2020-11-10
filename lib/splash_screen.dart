import 'dart:async';
import 'package:body_tune/helper.dart';
import 'package:body_tune/home_page.dart';
import 'package:body_tune/register_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    _timer = Timer(const Duration(milliseconds: 1500), () async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String userString = preferences.getString(SPText().user);

      if (userString == null) {
        debugPrint('SplashScreen User: null');
      } else if (userString.isEmpty) {
        debugPrint('SplashScreen User: IsEmpty');
      } else {
        debugPrint('SplashScreen User: ' + userString);
      }

      // if (userString == null) {
      if (true) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterPage()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
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
            child: Image.asset(CustomText().logoLocation),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(24.0, 64.0, 24.0, 24.0),
            child: Text(
              'Welcome!',
              style: TextStyle(
                  fontSize: 48,
                  color: CustomColor().text,
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
