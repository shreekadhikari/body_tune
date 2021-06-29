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
                child: Text(
                  'Next',
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

  _widgetStreamBuilder() {
    return StreamBuilder<List<BluetoothDevice>>(
      stream: Stream.periodic(Duration(seconds: 2))
          .asyncMap((_) => FlutterBlue.instance.connectedDevices),
      initialData: [],
      builder: (c, snapshot) => Column(
        children: snapshot.data
            .map((d) => ListTile(
                  title: Text(d.name),
                  subtitle: Text(d.id.toString()),
                  trailing: StreamBuilder<BluetoothDeviceState>(
                    stream: d.state,
                    initialData: BluetoothDeviceState.disconnected,
                    builder: (c, snapshot) {
                      if (snapshot.data == BluetoothDeviceState.connected) {
                        return RaisedButton(
                          child: Text('OPEN'),
                          onPressed: () => {},
                        );
                      }
                      return Text(snapshot.data.toString());
                    },
                  ),
                ))
            .toList(),
      ),
    );
  }

  void connectDevice(BluetoothDevice device) async {
    var characteristics;

    deviceRequired = device;

    debugPrint('BluetoothCheck ID: ' + device.id.toString());

    List<BluetoothDevice> check = await flutterBlue.connectedDevices;

    debugPrint('BluetoothCheck check: ' + check.toString());

    // device.disconnect();
    //
    await device.connect();

    // List<BluetoothService> services = await device.discoverServices();
    //
    // debugPrint('BluetoothCheck Services: ' + services.toString());
    //
    // services.forEach((service) async {
    //   if (service.uuid.toString() == 'fc4d0876-ca84-11eb-b8bc-0242ac130003') {
    //     characteristics = service.characteristics;
    //     for (BluetoothCharacteristic c in characteristics) {
    //       List<int> value = await c.read();
    //       debugPrint('BluetoothCheck value:' + value.toString());
    //     }
    //   }
    // });
  }
}
