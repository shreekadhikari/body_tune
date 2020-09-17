import 'package:body_tune/helper.dart';
import 'package:body_tune/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ContentMain();
  }
}

class _ContentMain extends State<SettingsPage> {
  String value1 = '3';
  String value2 = '3';
  String value3 = '3';
  String value4 = '3';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      backgroundColor: CustomColor().alternateBackground,
      body: Container(
        margin: EdgeInsets.all(40.0),
        padding: EdgeInsets.all(20.0),
        color: CustomColor().background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Time before test begin:',
                    style: textBody1(context),
                  ),
                  DropdownButton(
                    value: value1,
                    items: CustomText()
                        .dummyList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        value1 = newValue;
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Gap between tests:',
                    style: textBody1(context),
                  ),
                  DropdownButton(
                    value: value2,
                    items: CustomText()
                        .dummyList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        value2 = newValue;
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Time for breathing:',
                    style: textBody1(context),
                  ),
                  DropdownButton(
                    value: value3,
                    items: CustomText()
                        .dummyList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        value3 = newValue;
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              color: CustomColor().background,
              padding: EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Time for coughing:',
                    style: textBody1(context),
                  ),
                  DropdownButton(
                    value: value4,
                    items: CustomText()
                        .dummyList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        value4 = newValue;
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: CustomColor().background,
              ),
            ),
            RaisedButton(
              splashColor: Theme.of(context).primaryColor,
              child: Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              // color: Theme.of(context).accentColor,
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
