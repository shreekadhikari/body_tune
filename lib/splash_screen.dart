import 'dart:async';
import 'package:body_tune/activities_page.dart';
import 'package:body_tune/helper.dart';
import 'package:body_tune/home_page.dart';
import 'package:body_tune/more_info_page.dart';
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
      DateTime dateTimeCurrent = DateTime.now();

      if (userString == null) {
        debugPrint('SplashScreen User: null');
      } else if (userString.isEmpty) {
        debugPrint('SplashScreen User: IsEmpty');
      } else {
        debugPrint('SplashScreen User: ' + userString);
      }

      if (userString == null) {
        preferences.setString(SPText().date, dateTimeCurrent.toString());

        debugPrint('SplashScreen FirstDate: ' + dateTimeCurrent.toString());

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterPage()),
        );
      } else {
        String dateLastSavedString = preferences.getString(SPText().date);

        DateTime dateLastSaved = DateTime.parse(dateLastSavedString);
        debugPrint('SplashScreen LastSavedDate: ' + dateLastSaved.toString());
        var diff = dateTimeCurrent.difference(dateLastSaved);

        if (diff.inMinutes < 10) {
          debugPrint('SplashScreen Result: Not Yet');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } else {
          debugPrint('SplashScreen Result: Time');
          preferences.setString(SPText().date, dateTimeCurrent.toString());
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ActivitiesPage()),
          );
        }
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
