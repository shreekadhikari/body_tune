import 'dart:async';

import 'package:body_tune/questionnaire_page.dart';
import 'package:body_tune/results_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helper.dart';

class Mp5Coughing extends StatefulWidget {
  final BluetoothDevice device;

  Mp5Coughing({this.device});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ContentMain(device);
  }
}

class _ContentMain extends State<Mp5Coughing> {
  int time;
  SharedPreferences preferences;
  BluetoothDevice device;

  _ContentMain(BluetoothDevice device) {
    getSharedPreferences();
    this.device = device;
  }

  getSharedPreferences() async {
    this.preferences = await SharedPreferences.getInstance();
    time = int.parse(preferences.getString(SPText().coughing));
    Timer(Duration(seconds: time), () async {
      // if (userString == null) {
      if (true) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => QuestionnairePage(device: device)),
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
                'Coughing',
                textAlign: TextAlign.center,
                // style: textHeading1(context),
              ),
              bottomOpacity: 0.0,
              automaticallyImplyLeading: false),
          body: Container(
            color: CustomColor().alternateBackground,
            padding: EdgeInsets.all(40.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Spacer(
                  flex: 2,
                ),
                Container(
                  // height: 200.0,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 40.0),
                    color: Theme.of(context).primaryColor,
                    child: Image.asset('assets/images/coughing_gif.gif'),
                  ),
                ),
                Spacer(
                  flex: 2,
                ),
                Container(
                    alignment: Alignment.center,
                    child: Text(
                      'ACTION: PLEASE COUGH',
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
