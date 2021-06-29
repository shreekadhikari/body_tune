import 'package:body_tune/activities_page.dart';
import 'package:body_tune/home_page.dart';
import 'package:body_tune/results_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'helper.dart';

class QuestionnairePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ContentMain();
  }
}

class _ContentMain extends State<QuestionnairePage> {
  bool checkBoxAntiPlatelet = false;
  bool checkBoxAnticoagulant = false;
  bool checkBoxCurrentWeight = false;
  String checkBoxMeasuredCarotid;
  bool checkBoxActivityLevel = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'QuestionnairePage',
        ),
      ),
      backgroundColor: Color(0xFFD9D2D5),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(color: Color(0xFFFFFFFF)),
          padding: EdgeInsets.all(28.0),
          margin: EdgeInsets.all(40.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _widgetTitle(),
                _widgetSubtitle(),
                _widgetAntiPlatelet(),
                _widgetAnticoagulant(),
                _widgetMeasuredCarotid(),
                _widgetActivityLevel(),
                Spacer(),
                _widgetRegister(),
              ],
              // Column(
            ),
          ),
        ),
      ),
    );
  }

  _widgetTitle() {
    return Container(
      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: Text(
        'That was great!',
        style: textHeading1(context),
      ),
    );
  }

  _widgetSubtitle() {
    return Container(
      padding: EdgeInsets.only(top: 20.0, bottom: 40.0),
      child: Text(
        'Please provide us below additional information.',
        style: textHeading2(context),
      ),
    );
  }

  _widgetAntiPlatelet() {
    return CheckboxListTile(
      title: Text('Are you under any Anti-Platelet medication?'),
      value: checkBoxAntiPlatelet,
      onChanged: (newValue) {
        setState(() {
          checkBoxAntiPlatelet = newValue;
        });
      },
    );
  }

  _widgetAnticoagulant() {
    return CheckboxListTile(
      title: Text('Are you under any Anti-Coagulant medication?'),
      value: checkBoxAnticoagulant,
      onChanged: (newValue) {
        setState(() {
          checkBoxAnticoagulant = newValue;
        });
      },
    );
  }

  _widgetMeasuredCarotid() {
    return Row(
      children: [
        Expanded(
          child: Container(
            child: Text('Measured carotid side?'),
          ),
          flex: 2,
        ),
        Expanded(
          child: DropdownButton(
            value: checkBoxMeasuredCarotid,
            items: CustomText()
                .carotidSide
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String newValue) {
              setState(() {
                checkBoxMeasuredCarotid = newValue;
              });
            },
          ),
          flex: 1,
        )
      ],
    );
  }

  _widgetActivityLevel() {
    return Row(
      children: [
        Expanded(
          child: Container(
            child: Text('How was your activity level during last 7 days?'),
          ),
          flex: 1,
        ),
        Expanded(
          child: DropdownButton(
            value: checkBoxMeasuredCarotid,
            items: CustomText()
                .activityLevel
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String newValue) {
              setState(() {
                checkBoxMeasuredCarotid = newValue;
              });
            },
          ),
          flex: 1,
        ),
      ],
    );
  }

  _widgetRegister() {
    return RaisedButton(
      splashColor: Theme.of(context).primaryColor,
      child: Text(
        'RESULTS PAGE',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      color: Theme.of(context).accentColor,
      onPressed: () {
        if (_formKey.currentState.validate()) {
          // if (true) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ResultsPage()),
          );
        }
      },
    );
  }
}