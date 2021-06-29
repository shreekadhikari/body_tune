import 'package:body_tune/mp1_normal_breathing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'helper.dart';

class DataCheckPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ContentMain();
  }
}

class _ContentMain extends State<DataCheckPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Info'),
      ),
      body: Container(
        decoration: BoxDecoration(color: CustomColor().background),
        padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 16.0),
        margin: EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Spacer(),
            RaisedButton(
                child: Text(
                  'Start',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Mp1NormalBreathing()),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
