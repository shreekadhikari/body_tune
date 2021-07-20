import 'dart:async';

import 'package:body_tune/helper.dart';
import 'package:body_tune/mp2_apnea.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mp1NormalBreathing extends StatefulWidget {
  final BluetoothDevice device;

  Mp1NormalBreathing({this.device});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ContentMain(device);
  }
}

class _ContentMain extends State<Mp1NormalBreathing> {
  int time;
  SharedPreferences preferences;
  BluetoothDevice device;

  _ContentMain(BluetoothDevice bluetoothDevice) {
    getSharedPreferences();
    this.device = bluetoothDevice;
  }

  getSharedPreferences() async {
    this.preferences = await SharedPreferences.getInstance();
    time = int.parse(preferences.getString(SPText().normalBreathing));
    Timer(Duration(seconds: time), () async {
      // if (userString == null) {
      if (true) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Mp2Apnea(device: device)),
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
                'Normal Breathing',
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
                  //height: 200.0,
                  // color: CustomColor().background,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 40.0),
                    color: Theme.of(context).primaryColor,
                    child: Image.asset('assets/images/breathe_gif.gif'),
                  ),
                ),
                Spacer(
                  flex: 2,
                ),
                Container(
                    alignment: Alignment.center,
                    child: Text(
                      'ACTION: PLEASE TAKE DEEP BREATHS',
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
