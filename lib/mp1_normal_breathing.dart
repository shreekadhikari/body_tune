import 'dart:async';

import 'package:body_tune/helper.dart';
import 'package:body_tune/mp2_swallowing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mp1NormalBreathing extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ContentMain();
  }
}

class _ContentMain extends State<Mp1NormalBreathing> {
  int time;
  SharedPreferences preferences;

  _ContentMain() {
    getSharedPreferences();
  }

  getSharedPreferences() async {
    this.preferences = await SharedPreferences.getInstance();
    time = int.parse(preferences.getString(SPText().normalBreathing));
    Timer(Duration(seconds: time), () async {
      // if (userString == null) {
      if (true) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Mp2Swallowing()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
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
            Spacer(),
            Container(
              //height: 200.0,
              // color: CustomColor().background,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 40.0),
                color: Theme.of(context).primaryColor,
                child: Image.asset('assets/images/breathe_gif.gif'),
              ),
            ),
            Spacer(),
            Container(
                child: Text(
              '         ACTION: PLEASE TAKE DEEP BREATHS',
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
            //         MaterialPageRoute(builder: (context) => Mp2Swallowing()),
            //       );
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
