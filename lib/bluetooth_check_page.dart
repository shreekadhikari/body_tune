import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_blue/flutter_blue.dart';

import 'helper.dart';

class BluetoothCheckPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ContentMain();
  }
}

class _ContentMain extends State<BluetoothCheckPage> {
  FlutterBlue flutterBlue = FlutterBlue.instance;

  List<ScanResult> scanResult;
  bool showResult = false;

  @override
  void initState() {
    flutterBlue.startScan(timeout: Duration(seconds: 4));

    flutterBlue.scanResults.listen((results) {
      // do something with scan results
      scanResult = results;
      for (ScanResult r in scanResult) {
        debugPrint(
            'BluetoothCheckPage: ${r.device.name} found! rssi: ${r.rssi}');
        debugPrint('BluetoothCheckPage: ' + results.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Check Page'),
      ),
      body: Container(
        decoration: BoxDecoration(color: CustomColor().background),
        padding: EdgeInsets.all(28.0),
        margin: EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 500.0,
              child: showResult
                  ? ListView.builder(
                      itemCount: scanResult.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Text(scanResult[index].device.id.toString());
                      },
                    )
                  : Text('Click on the botton to show results'),
            ),
            Spacer(),
            RaisedButton(
                child: Text(
                  'Check',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    showResult = true;
                  });
                }),
          ],
        ),
      ),
    );
  }
}
