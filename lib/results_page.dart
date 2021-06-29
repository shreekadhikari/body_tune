import 'dart:convert';

import 'package:body_tune/home_page.dart';
import 'package:body_tune/test.dart';
import 'package:body_tune/user.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helper.dart';

class ResultsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ContentMain();
  }
}

class _ContentMain extends State<ResultsPage> {
  SharedPreferences preferences;
  DatabaseReference _ref;
  String bmiLast;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    _ref = FirebaseDatabase.instance.reference();
    this.preferences = await SharedPreferences.getInstance();
    setState(() {
      bmiLast = preferences.getString(SPText().bmi);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        child: _widgetContent(),
        onWillPop: () async {
          return false;
        });
  }

  _widgetContent() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Results',
          textAlign: TextAlign.center,
          // style: textHeading1(context),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              // alignment: Alignment.center,
              child: Text(
                'Congratulations!!',
                style: TextStyle(fontSize: 36, color: CustomColor().accent),
              ),
            ),
            Spacer(),
            Text(
              'Heart Rate:',
              style: TextStyle(
                fontSize: 36,
                color: Colors.grey,
                fontFamily: 'Arial',
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(
              flex: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                Text(
                  '80',
                  style: TextStyle(
                    fontSize: 160,
                    // color: Colors.grey,
                    fontFamily: 'Arial',
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'BPM',
                  style: TextStyle(
                    fontSize: 36,
                    // color: Colors.grey,
                    fontFamily: 'Arial',
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              child: Text('Your Last BMI Index: $bmiLast'),
            ),
            Spacer(
              flex: 3,
            ),
            _widgetRaisedButton()
          ],
        ),
      ),
    );
  }

  _widgetRaisedButton() {
    return RaisedButton(
      splashColor: Theme.of(context).primaryColor,
      child: Text(
        'Finish',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      onPressed: () async {
        storeResult();

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      },
    );
  }

  void storeResult() async {
    String userString = preferences.getString(SPText().user);
    List<String> listResult =
        preferences.getStringList(SPText().testResultList);
    List<String> listDate = preferences.getStringList(SPText().testDateList);

    UserInfo userInfo = UserInfo.fromJson(jsonDecode(userString));

    String dateTime =
        DateFormat("yyyy-MM-dd hh:mm").format(DateTime.now()).toString();
    String result = '80';
    int data;

    if (listResult == null) {
      listResult = [];
    }
    if (listDate == null) {
      listDate = [];
    }

    _ref
        .child(FirebaseText().testInfoCounter)
        .once()
        .then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        data = int.parse(snapshot.value);
        data += 1;
      } else {
        data = 0;
      }

      print('ResultsPage TestCounter : ' + data.toString());

      _ref.child(FirebaseText().testInfoCounter).set(data.toString());
      _ref
          .child(FirebaseText().testInfo)
          .child(data.toString())
          .set(TestInfo(userInfo.id, result, dateTime).toJson());
    });

    listResult.add(result);
    listDate.add(dateTime);

    print('ResultsPage ResultList : ' + listResult.toString());
    print('ResultsPage DateList : ' + listDate.toString());

    preferences.setStringList(SPText().testResultList, listResult);
    preferences.setStringList(SPText().testDateList, listDate);
  }
}
