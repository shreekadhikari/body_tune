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
  bool showMsg = true;
  bool firstTimeScan = true;
  String msg = '';

  @override
  void initState() {
    super.initState();
    flutterBlue = FlutterBlue.instance;
    scanDevices();
  }

  scanDevices() async {
    flutterBlue.startScan(timeout: Duration(seconds: 4));

    flutterBlue.scanResults.listen((results) {
      setState(() async {
        scanResult = results;
        if (await flutterBlue.isOn) {
          isBluetoothEnabled(true);
        } else {
          isBluetoothEnabled(false);
        }
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
        margin: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Visibility(
              visible: showMsg,
              child: Text(msg),
            ),
            RefreshIndicator(
              backgroundColor: CustomColor().primary,
              color: Colors.white,
              strokeWidth: 2.0,
              onRefresh: () =>
                  flutterBlue.startScan(timeout: Duration(seconds: 4)),
              child: _widgetBluetoothDevices(),
            ),
            Spacer(),
            _widgetNextButton(),
          ],
        ),
      ),
    );
  }

  Widget _widgetBluetoothDevices() {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.7,
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height - 225),
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
                  flex: 3,
                ),
                Expanded(
                  child: RaisedButton(
                      child: Text(
                        'Connect',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        connectDevice(bluetoothDevice);
                      }),
                  flex: 2,
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
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Bluetooth Device connected"),
    ));
    print('Bluetooth Page: Button enabled');
  }

  _widgetNextButton() {
    return RaisedButton(
        color: !isBluetoothConnected ? Colors.grey : CustomColor().accent,
        child: Text(
          'Next',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          if (isBluetoothConnected) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DataCheckPage(device: deviceRequired)),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                "Bluetooth Device not connected",
              ),
            ));
            print('Bluetooth Page: Button disabled');
          }
        });
  }

  isBluetoothEnabled(bool adapter) {
    setState(() {
      if (adapter) {
        showMsg = false;
      } else {
        showMsg = true;
        msg = 'Enable bluetooth and try again';
      }
    });
  }
}
