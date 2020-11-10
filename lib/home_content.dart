import 'dart:convert';

import 'package:body_tune/measurement_page_1.dart';
import 'package:body_tune/settings_page.dart';
import 'package:body_tune/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ContentMain();
  }
}

class _ContentMain extends State<HomeContent> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  SharedPreferences preferences;
  UserInfo userInfo;
  TextEditingController nameController = TextEditingController();
  TextEditingController dataDisplayController = TextEditingController();

  _ContentMain() {
    nameController.text = 'Hi!';
    dataDisplayController.text = 'Loading...';
    getSharedPreferences();
  }

  getSharedPreferences() async {
    this.preferences = await SharedPreferences.getInstance();
    String userString = preferences.getString('user');
    this.userInfo = UserInfo.fromJson(jsonDecode(userString));
    nameController.text = 'Hi, ' + userInfo.firstName + '!';
    dataDisplayController.text = userInfo.toString();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        decoration: BoxDecoration(color: Color(0xFFFFFFFF)),
        child: Column(
          children: [
            Container(height: 32.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                widgetSettings(),
                // IconButton(
                //   icon: Icon(
                //     Icons.settings,
                //     color: Theme.of(context).primaryColor,
                //   ),
                //   onPressed: () {
                //     setState(() {
                //       Scaffold.of(context).showSnackBar(SnackBar(
                //         content: Text('Settings'),
                //       ));
                //     });
                //   },
                // )
              ],
            ),
            widgetLogo(),
            Spacer(),
            widgetName(),
            Spacer(),
            widgetStartMeasurement(),
            Spacer(flex: 2),
            // widgetUserInfoDebug(),
          ],
        ));
  }

  widgetSettings() {
    return RaisedButton(
      padding: EdgeInsets.all(8.0),
      child: Icon(
        Icons.settings,
        color: Theme.of(context).primaryColor,
      ),
      shape: CircleBorder(),
      elevation: 0.0,
      // splashColor: Theme.of(context).accentColor,
      color: Colors.white,
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SettingsPage()));
        // showSnackBar(context, 'Settings');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SettingsPage()),
        );
      },
    );
  }

  widgetLogo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32.0),
      color: Theme.of(context).primaryColor,
      child: Image.asset('assets/images/logo_body_tune.jpeg'),
    );
  }

  widgetName() {
    return TextField(
      controller: nameController,
      readOnly: true,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      style: TextStyle(
          fontSize: 36,
          color: Theme.of(context).accentColor,
          fontFamily: 'Arial',
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold),
    );
  }

  widgetStartMeasurement() {
    return SizedBox(
      height: 220.0,
      width: 220.0,
      child: RaisedButton(
        elevation: 10,
        shape: CircleBorder(),
        splashColor: Theme.of(context).accentColor,
        color: Theme.of(context).primaryColor,
        child: Text(
          'Start\nMeasurement',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontFamily: 'Arial',
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
        ),
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MeasurementPage1()),
          );
        },
      ),
    );
  }

  widgetUserInfoDebug() {
    return TextField(
      controller: dataDisplayController,
    );
  }
}
