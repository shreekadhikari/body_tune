import 'dart:async';

import 'package:body_tune/mp5_coughing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helper.dart';

class Mp4Swallowing extends StatefulWidget {
  final BluetoothDevice device;

  Mp4Swallowing({this.device});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ContentMain(device);
  }
}

class _ContentMain extends State<Mp4Swallowing> {
  int time;
  SharedPreferences preferences;
  BluetoothDevice device;

  _ContentMain(BluetoothDevice device) {
    getSharedPreferences();
    this.device = device;
  }

  getSharedPreferences() async {
    this.preferences = await SharedPreferences.getInstance();
    time = int.parse(preferences.getString(SPText().swallowing));
    Timer(Duration(seconds: time), () async {
      // if (userString == null) {
      if (true) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Mp5Coughing(device: device)),
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
                'Swallowing',
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
                Spacer(
                  flex: 2,
                ),
                Container(
                  // height: 200.0,
                  // color: CustomColor().alternateBackground,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 40.0),
                    color: Theme.of(context).primaryColor,
                    child: Image.asset('assets/images/swallow_gif.gif'),
                  ),
                ),
                Spacer(flex: 2),
                Container(
                    alignment: Alignment.center,
                    child: Text(
                      'ACTION: PLEASE DO SWALLOW',
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
