import 'package:body_tune/activities_page.dart';
import 'package:body_tune/home_page.dart';
import 'package:body_tune/results_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TrafficLights extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ContentMain();
  }

}
class _ContentMain extends State <TrafficLights> {
  // 1
  bool _hasBeenPressed = false;

  String get title => null;
  Color color = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Traffic Light"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: new Text('Change Color'),
              textColor: Colors.red,
              color: color,
              // 2
              onPressed: () => {
                setState(() {
                  _hasBeenPressed = !_hasBeenPressed;
                  if(_hasBeenPressed){
                    color= Colors.green;
                  }else{
                    color= Colors.red;
                  }
                })
              },
              // 3
              // color: _hasBeenPressed ? Colors.green;
            )
          ],
        ),
      ),
    );
  }
}