import 'package:body_tune/mp1_normal_breathing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import 'helper.dart';

class DataCheckPage extends StatefulWidget {
  final BluetoothDevice device;

  DataCheckPage({this.device});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ContentMain(device: device);
  }
}

class _ContentMain extends State<DataCheckPage> {
  BluetoothDevice device;

  _ContentMain({this.device});

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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _widgetRecordButton(),
          ],
        ),
      ),
    );
  }

  _widgetRecordButton() {
    return SizedBox(
      height: 220.0,
      width: 220.0,
      child: RaisedButton(
          elevation: 10,
          shape: CircleBorder(),
          splashColor: Theme.of(context).primaryColor,
          color: Theme.of(context).accentColor,
          child: Text(
            'Start\nRecording',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontFamily: 'Arial',
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            startRecording();
            // test();
          }),
    );
  }

  void startRecording() async {
    print("Data check: " + device.id.toString());
    List<BluetoothService> services = await device.discoverServices();
    services.forEach((service) async {
      if (service.uuid.toString() == 'fc4d0876-ca84-11eb-b8bc-0242ac130003') {
        var characteristics = service.characteristics;
        for (BluetoothCharacteristic c in characteristics) {
          if (c.uuid.toString() == '746cbbe3-ca87-11eb-b8bc-0242ac130003') {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Mp1NormalBreathing(device: device)),
            );
            await c.write([34]);
          }
        }
      }
    });
  }

  void test() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Mp1NormalBreathing(device: device)),
    );
  }
}
