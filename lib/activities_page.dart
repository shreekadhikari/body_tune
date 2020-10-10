import 'package:body_tune/home_page.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

import 'helper.dart';

class ActivitiesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ContentMain();
  }
}

class _ContentMain extends State<ActivitiesPage> {
  int currentIndex = 0;
  String dropdownValue = '0';

  // List<Widget> widgetDropDownList = <Widget>[widgetDays()];

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
            Container(
              child: Text(
                CustomText().activitiesQues[currentIndex],
                style: textBody1(context),
              ),
            ),
            Spacer(flex: 1),
            Row(
              children: [
                Spacer(),
                widgetDays(),
                Spacer(),
              ],
            ),
            // NumberPicker.integer(
            //   scrollDirection: Axis.horizontal,
            //   highlightSelectedValue: true,
            //   minValue: 0,
            //   maxValue: 7,
            //   initialValue: 0,
            // ),
            Spacer(
              flex: 2,
            ),
            widgetNextButton(),
          ],
        ),
      ),
    );
  }

  widgetNextButton() {
    return RaisedButton(
      splashColor: Theme.of(context).primaryColor,
      child: Text(
        'Next',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      onPressed: () async {
        setState(() {
          if (currentIndex == 6) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else {
            currentIndex =
                (currentIndex + 1) % CustomText().activitiesQues.length;
          }
        });
      },
    );
  }

  widgetDays() {
    List<String> tempList = CustomText().daysInWeek;

    // if (currentIndex == 0 || currentIndex == 2 || currentIndex == 4) {
    //   tempList = CustomText().daysInWeek;
    // } else {
    //   tempList = CustomText().hoursInDays;
    // }

    return DropdownButton<String>(
      value: dropdownValue,
      iconSize: 24,
      elevation: 36,
      hint: Text('Select a value'),
      underline: Container(
        height: 2,
        color: CustomColor().accent,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: tempList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
