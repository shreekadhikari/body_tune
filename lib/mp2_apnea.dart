import 'dart:async';

import 'package:body_tune/bmicalc_page.dart';
import 'package:body_tune/home_page.dart';
import 'package:body_tune/mp1_normal_breathing.dart';
import 'package:body_tune/mp3_guided_breathing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helper.dart';

class Mp2Apnea extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ContentMain();
  }
}

class _ContentMain extends State<Mp2Apnea> {
  int time;
  SharedPreferences preferences;

  _ContentMain() {
    getSharedPreferences();
  }

  getSharedPreferences() async {
    this.preferences = await SharedPreferences.getInstance();
    time = int.parse(preferences.getString(SPText().apnea));
    Timer(Duration(seconds: time), () async {
      // if (userString == null) {
      if (true) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Mp3GuidedBreathing()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
              title: Text(
                'Apnea',
                textAlign: TextAlign.center,
                // style: textHeading1(context),
              ),
              bottomOpacity: 0.0,
              automaticallyImplyLeading: false),
          body: Container(
            color: CustomColor().alternateBackground,
            padding: EdgeInsets.all(40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Spacer(flex: 2),
                Container(
                  //height: 200.0,
                  // color: CustomColor().background,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 40.0),
                    color: Theme.of(context).primaryColor,
                    child: Image.asset('assets/images/apnea_gif.gif'),
                  ),
                ),
                Spacer(flex: 2),
                Container(
                    alignment: Alignment.center,
                    child: Text(
                      'ACTION: PLEASE TAKE DEEP BREATH AND HOLD',
                      //style: textBody1(context),
                    )),
                Spacer(
                  flex: 1,
                ),
              ],
            ),
          ),
        ),
        onWillPop: () async {
          return false;
        });
  }
}
