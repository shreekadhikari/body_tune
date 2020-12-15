import 'package:body_tune/home_page.dart';
import 'package:body_tune/mp1_normal_breathing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'helper.dart';

class Mp5Apnea extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ContentMain();
  }
}

class _ContentMain extends State<Mp5Apnea> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Apnea',
            textAlign: TextAlign.center,
            // style: textHeading1(context),
          ),
          bottomOpacity: 0.0,
          automaticallyImplyLeading: false),
      body: Container(
        color: CustomColor().alternateBackground,
        padding: EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Spacer(),
            Container(
              //height: 200.0,
              // color: CustomColor().background,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 40.0),
                color: Theme.of(context).primaryColor,
                child: Image.asset('assets/images/apnea_gif.gif'),
              ),
            ),
            Spacer(),
            RaisedButton(
              splashColor: Theme.of(context).primaryColor,
              child: Text(
                'Finish',
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
                    MaterialPageRoute(builder: (context) => HomePage()),
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
