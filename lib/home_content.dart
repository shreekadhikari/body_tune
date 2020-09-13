
import 'package:body_tune/helper.dart';
import 'package:body_tune/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
                RaisedButton(
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
                    // showSnackBar(context, 'Settings');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsPage()),
                    );
                  },
                ),
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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 32.0),
              color: Theme.of(context).primaryColor,
              child: Image.asset('assets/images/logo_body_tune.jpeg'),
            ),
            Expanded(child: Container()),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Hi, Jane Doe!',
                style: TextStyle(
                    fontSize: 36,
                    color: Theme.of(context).accentColor,
                    fontFamily: 'Arial',
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(child: Container()),
            SizedBox(
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
                  showSnackBar(context, 'Test will begin from here');
                },
              ),
            ),
            Expanded(
              child: Container(),
              flex: 2,
            ),
          ],
        ));
  }
}
