import 'package:body_tune/measurement_page_4.dart';
import 'package:body_tune/results_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'helper.dart';

class MeasurementPage3 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ContentMain();
  }
}

class _ContentMain extends State<MeasurementPage3> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Coughing',
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
              // height: 200.0,
              // color: CustomColor().alternateBackground,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 40.0),
                color: Theme.of(context).primaryColor,
                child: Image.asset('assets/images/coughing_gif.gif'),
              ),
            ),
            Spacer(),
            RaisedButton(
              splashColor: Theme.of(context).primaryColor,
              child: Text(
                'Next',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              // color: Theme.of(context).accentColor,
              onPressed: () async {
                // if (_formKey.currentState.validate()) {
                if (true) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MeasurementPage4()),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
