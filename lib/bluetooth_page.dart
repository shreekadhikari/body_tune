import 'dart:developer';

import 'package:body_tune/start_recording_page.dart';
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
  FlutterBlue flutterBlue;
  BluetoothDevice deviceRequired;
  bool isBluetoothConnected = false;
  List<ScanResult> scanResult = [];

  @override
  void initState() {
    super.initState();
    flutterBlue = FlutterBlue.instance;

    flutterBlue.startScan(timeout: Duration(seconds: 4));

    flutterBlue.scanResults.listen((results) {
      setState(() {
        scanResult = results;
      });
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
        padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 16.0),
        margin: EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RefreshIndicator(
              backgroundColor: CustomColor().primary,
              color: Colors.white,
              strokeWidth: 2.0,
              onRefresh: () =>
                  FlutterBlue.instance.startScan(timeout: Duration(seconds: 4)),
              child: _widgetBluetoothDevices(),
            ),
            Spacer(),
            RaisedButton(
                color:
                    !isBluetoothConnected ? Colors.grey : CustomColor().accent,
                child: Text(
                  'Next',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (isBluetoothConnected) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DataCheckPage(device: deviceRequired)),
                    );
                  } else {
                    print('Bluetooth Page: Button disabled');
                  }
                }),
          ],
        ),
      ),
    );
  }

  Widget _widgetBluetoothDevices() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      child: ListView.builder(
        itemCount: scanResult.length,
        itemBuilder: (BuildContext context, int index) {
          BluetoothDevice bluetoothDevice = scanResult[index].device;
          return Container(
            padding: EdgeInsets.only(bottom: 5),
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Expanded(
                  child: Text(bluetoothDevice.id.toString() +
                      ', ' +
                      bluetoothDevice.name),
                  flex: 2,
                ),
                Expanded(
                  child: RaisedButton(
                      child: Text(
                        'Connect',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        connectDevice(bluetoothDevice);
                      }),
                  flex: 1,
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void connectDevice(BluetoothDevice device) async {
    deviceRequired = device;

    debugPrint('BluetoothCheck ID: ' + device.id.toString());

    await device.connect();

    debugPrint('BluetoothCheck Connection: Connected to ${device.id}');

    setState(() {
      isBluetoothConnected = true;
      print('Bluetooth Page: Button enabled');
    });
  }
}
