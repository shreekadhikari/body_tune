import 'dart:developer';

import 'package:body_tune/mp1_normal_breathing.dart';
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
        // debugPrint('BluetoothCheckPage: ${r.device.id} found! rssi: ${r.rssi}');
        // debugPrint('BluetoothCheckPage: ' + results.toString());
        // if (r.device.id.toString() == 'B8:27:EB:99:1E:99') {
        if (r.device.id.toString() == '70:C9:4E:D1:5A:0A') {
          deviceRequired = r.device;
          debugPrint('BluetoothCheckPage: The device has been found');
          connectDevice(deviceRequired);
          break;
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
                  'Next',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  // debugPrint('BluetoothCheckPage SelectedDevice: ' +
                  //     deviceRequired.toString());
                  // await deviceRequired.connect();
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

  void connectDevice(BluetoothDevice device) async {
    await device.connect();
    BluetoothService bluetoothService;
    List<BluetoothService> services = await device.discoverServices();
    services.forEach((service) {
      if (service.uuid.toString() == '0000180f-0000-1000-8000-00805f9b34fb') {
        debugPrint('BluetoothCheckPage ServiceUUID: ' + service.uuid.toString());
        bluetoothService = service;
      }
    });
    var characteristics = bluetoothService.characteristics;
    for (BluetoothCharacteristic c in characteristics) {
      List<int> value = await c.read();
      debugPrint('BluetoothCheckPage CharacteristicsValue: ' + value.toString());
      debugPrint(
          'BluetoothCheckPage Characteristics: ' + characteristics.toString());
    }
  }
}
