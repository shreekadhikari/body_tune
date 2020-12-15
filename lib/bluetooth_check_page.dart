import 'package:body_tune/measurement_page_1.dart';
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
  BluetoothDevice deviceRequired;

  List<ScanResult> scanResult = [];

  @override
  void initState() {
    flutterBlue.startScan(timeout: Duration(seconds: 4));

    flutterBlue.scanResults.listen((results) {
      // do something with scan results
      setState(() {
        scanResult = results;
      });
      for (ScanResult r in scanResult) {
        debugPrint('BluetoothCheckPage: ${r.device.id} found! rssi: ${r.rssi}');
        debugPrint('BluetoothCheckPage: ' + results.toString());
        // if (r.device.id.toString() == 'B8:27:EB:99:1E:99') {
        if (r.device.id.toString() == '73:B1:5F:4F:60:DE') {
          deviceRequired = r.device;

          debugPrint('BluetoothCheckPage: The device has been found');
        }
      }
    });

    flutterBlue.stopScan();
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
              child: ListView.builder(
                itemCount: scanResult.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(scanResult[index].device.id.toString() +
                        ', ' +
                        scanResult[index].device.name),
                  );
                },
              ),
            ),
            Spacer(),
            RaisedButton(
                child: Text(
                  'Check',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  // debugPrint('BluetoothCheckPage SelectedDevice: ' +
                  //     deviceRequired.toString());
                  // await deviceRequired.connect();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MeasurementPage1()),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
