import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:body_tune/home_page.dart';
import 'package:body_tune/test.dart';
import 'package:body_tune/user.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helper.dart';

class ResultsPage extends StatefulWidget {
  final BluetoothDevice device;

  ResultsPage({this.device});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ContentMain(device);
  }
}

class _ContentMain extends State<ResultsPage> {
  SharedPreferences preferences;
  DatabaseReference _ref;
  StorageReference storageRef;
  String bmiLast;
  BluetoothDevice device;
  List<int> data = [];
  String tempPath;
  String dateTime;
  List<String> listResult;
  List<String> listDate;
  UserInfo userInfo;
  bool dataReceivedFinished = false;

  _ContentMain(BluetoothDevice device) {
    this.device = device;
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    _ref = FirebaseDatabase.instance.reference();
    storageRef = FirebaseStorage.instance.ref();
    this.preferences = await SharedPreferences.getInstance();
    setState(() {
      bmiLast = preferences.getString(SPText().bmi);
    });

    String userString = preferences.getString(SPText().user);
    listResult = preferences.getStringList(SPText().testResultList);
    listDate = preferences.getStringList(SPText().testDateList);
    userInfo = UserInfo.fromJson(jsonDecode(userString));

    List<BluetoothService> services = await device.discoverServices();

    services.forEach((service) async {
      if (service.uuid.toString() == 'fc4d0876-ca84-11eb-b8bc-0242ac130003') {
        var characteristics = service.characteristics;
        for (BluetoothCharacteristic c in characteristics) {
          if (c.uuid.toString() == '746cbbe2-ca87-11eb-b8bc-0242ac130003') {
            List<int> newValue = [];

            int i = 0;
            while (true) {
              newValue = await c.read();
              data.addAll(newValue);
              print('ReceivedInt $i: ${newValue.length.toString()}');
              print('TotalInt $i: ${data.length.toString()}');
              print('TotalInt $i: ${newValue.toString()}');
              i++;
              if (newValue.length == 44) {
                break;
              }
            }

            print('Before Length: ${data.length}');
            print('Before Data: $data');

            List<int> headers = data.sublist(data.length - 44, data.length);
            data.removeRange(data.length - 44, data.length);
            data = headers..addAll(data);

            print('After Length: ${data.length}');
            print('After Data: $data');

            setState(() {
              dataReceivedFinished = true;
            });
          }
        }
      }

      try {
        Directory tempDir = await getTemporaryDirectory();
        tempPath = tempDir.path;
        String filePath = tempPath + '/recording.wav';

        Uint8List wavData = Uint8List.fromList(data);

        File wavFile = await File(filePath).writeAsBytes(wavData);
        await File(tempPath + '/recording.txt').writeAsString(data.toString());

        dateTime =
            DateFormat("yyyy-MM-dd hh:mm").format(DateTime.now()).toString();

        String filename = userInfo.id + dateTime + '.wav';

        final StorageUploadTask uploadTask = storageRef.child(filename).putFile(
              wavFile,
            );
      } catch (e) {
        print(e);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Results',
              textAlign: TextAlign.center,
              // style: textHeading1(context),
            ),
            automaticallyImplyLeading: false,
          ),
          body: !dataReceivedFinished
              ? _widgetContentAlternate()
              : _widgetContent(),
        ),
        onWillPop: () async {
          return true;
        });
  }

  _widgetContentAlternate() {
    return Container(
      padding: EdgeInsets.all(40.0),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Receiving data from bluetooth. Please do not exit the app.'),
          Container(
            height: 24,
          ),
          LinearProgressIndicator(
            color: Theme.of(context).accentColor,
            backgroundColor: Colors.white,
            minHeight: 5,
          )
        ],
      ),
    );
  }

  _widgetContent() {
    return Container(
      padding: EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            child: Text(
              'Congratulations!!',
              style: TextStyle(fontSize: 36, color: CustomColor().accent),
            ),
          ),
          Spacer(),
          Text(
            'Heart Rate:',
            style: TextStyle(
              fontSize: 36,
              color: Colors.grey,
              fontFamily: 'Arial',
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(
            flex: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              Text(
                '80',
                style: TextStyle(
                  fontSize: 160,
                  // color: Colors.grey,
                  fontFamily: 'Arial',
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'BPM',
                style: TextStyle(
                  fontSize: 36,
                  // color: Colors.grey,
                  fontFamily: 'Arial',
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.all(20.0),
            child: Text('Your Last BMI Index: $bmiLast'),
          ),
          Spacer(
            flex: 3,
          ),
          _widgetRaisedButton()
        ],
      ),
    );
  }

  _widgetRaisedButton() {
    return RaisedButton(
      splashColor: Theme.of(context).primaryColor,
      child: Text(
        'Finish',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      onPressed: () async {
        storeResult();

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      },
    );
  }

  void storeResult() async {
    String result = '80';
    int data;

    if (listResult == null) {
      listResult = [];
    }
    if (listDate == null) {
      listDate = [];
    }

    _ref
        .child(FirebaseText().testInfoCounter)
        .once()
        .then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        data = int.parse(snapshot.value);
        data += 1;
      } else {
        data = 0;
      }

      print('ResultsPage TestCounter : ' + data.toString());

      _ref.child(FirebaseText().testInfoCounter).set(data.toString());
      _ref
          .child(FirebaseText().testInfo)
          .child(data.toString())
          .set(TestInfo(userInfo.id, result, dateTime).toJson());
    });

    listResult.add(result);
    listDate.add(dateTime);

    print('ResultsPage ResultList : ' + listResult.toString());
    print('ResultsPage DateList : ' + listDate.toString());

    preferences.setStringList(SPText().testResultList, listResult);
    preferences.setStringList(SPText().testDateList, listDate);
  }
}
