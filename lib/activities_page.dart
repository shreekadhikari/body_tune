import 'dart:convert';

import 'package:body_tune/home_page.dart';
import 'package:body_tune/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'helper.dart';
import 'package:body_tune/helper.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';

class ActivitiesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ContentMain();
  }
}

class _ContentMain extends State<ActivitiesPage> {
  SharedPreferences preferences;
  int currentIndex = 0;
  DatabaseReference _ref;
  List<String> dropDownActivity = CustomText().defaultDropDownValue;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: CustomColor().alternateBackground,
      appBar: AppBar(
        title: Text('Activities'),
      ),
      body: Container(
        decoration: BoxDecoration(color: CustomColor().background),
        padding: EdgeInsets.all(28.0),
        margin: EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Spacer(flex: 2),
            widgetQues(),
            Spacer(flex: 1),
            widgetDaysAndHours(),
            Spacer(flex: 2),
            widgetNextButton(),
          ],
        ),
      ),
    );
  }

  widgetQues() {
    return Container(
      child: Text(
        CustomText().activitiesQues[currentIndex],
        style: textBody1(context),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _ref = FirebaseDatabase.instance.reference().child('UserInfo');
  }

  widgetDaysAndHours() {
    List<String> tempList = CustomText().daysInWeek;

    if (checkIfDays(currentIndex)) {
      tempList = CustomText().daysInWeek;
    } else {
      tempList = CustomText().hoursInDays;
    }

    return Row(
      children: [
        Spacer(),
        DropdownButton<String>(
          value: dropDownActivity[currentIndex],
          iconSize: 24,
          elevation: 36,
          hint: Text('Select a value'),
          underline: Container(
            height: 2,
            color: CustomColor().accent,
          ),
          onChanged: (String newValue) {
            setState(() {
              dropDownActivity[currentIndex] = newValue;
            });
          },
          items: tempList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        Spacer(),
      ],
    );
  }

  widgetNextButton() {
    return RaisedButton(
      splashColor: Theme.of(context).primaryColor,
      child: Text(
        currentIndex == 6 ? 'Finish' : 'Next',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      onPressed: () async {
        setState(() {
          if (currentIndex == 6) {
            String activityLevel = calculateActivityLevel(dropDownActivity);

            storeActivityLevel(activityLevel);
            //storeUserDetail();

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else {
            if (checkIfDays(currentIndex) &&
                dropDownActivity[currentIndex] == '0') currentIndex += 1;
            currentIndex =
                (currentIndex + 1) % CustomText().activitiesQues.length;
          }
        });
      },
    );
  }

  bool checkIfDays(int value) {
    if (value == 0 || value == 2 || value == 4 || value == 6)
      return true;
    else
      return false;
  }

  String calculateActivityLevel(List<String> activityDataString) {
    List<int> activityDataInt = List<int>(activityDataString.length);
    double met;
    String activityLevel;

    for (int i = 0; i < activityDataString.length; i++) {
      if (checkIfDays(i))
        activityDataInt[i] = int.parse(activityDataString[i]);
      else
        activityDataInt[i] =
            CustomText().mapTimeIntoMins[activityDataString[i]];
    }

    met = activityDataInt[0] * activityDataInt[1] * 8.0 +
        activityDataInt[2] * activityDataInt[3] * 4.0 +
        activityDataInt[4] * activityDataInt[5] * 3.3;

    if (met >= 1500) {
      activityLevel = '3';
    } else if (met >= 600) {
      activityLevel = '2';
    } else {
      activityLevel = '1';
    }

    debugPrint('ActivityPage MET: $met');
    debugPrint('ActivityPage Level: $activityLevel');

    return activityLevel;
  }

  void storeActivityLevel(String level) async {
    this.preferences = await SharedPreferences.getInstance();
    String userString = preferences.getString(SPText().user);
    UserInfo userInfo = UserInfo.fromJson(jsonDecode(userString));
    userInfo.activity = level;

    String userId = userInfo.firstName + '-' + userInfo.dob;
    userId = userId.replaceAll('/', '-');

    debugPrint('ActivityPage UserID:' + userId);

    debugPrint('ActivityPage UserLevel:' + userInfo.activity);

    preferences.setString(SPText().user, jsonEncode(userInfo));

    debugPrint('ActivityPage UserWithActivity: ' + userInfo.toString());

    _ref.child(userId).set(userInfo.toJson());

    // _ref.push().set(userInfo.toJson()).then((value) {});
  }
}
