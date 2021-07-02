import 'dart:convert';

import 'dart:io';
import 'dart:typed_data';
import 'package:body_tune/start_recording_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

import 'package:body_tune/activities_page.dart';
import 'package:body_tune/bluetooth_page.dart';
import 'package:body_tune/bmicalc_page.dart';
import 'package:body_tune/helper.dart';
import 'package:body_tune/mp1_normal_breathing.dart';
import 'package:body_tune/results_page.dart';
import 'package:body_tune/settings_page.dart';
import 'package:body_tune/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wave_builder/wave_builder.dart';

class HomeContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ContentMain();
  }
}

class _ContentMain extends State<HomeContent> {
  @override
  void initState() {
    super.initState();
  }

  SharedPreferences preferences;
  UserInfo userInfo;
  TextEditingController nameController = TextEditingController();
  TextEditingController dataDisplayController = TextEditingController();

  _ContentMain() {
    nameController.text = 'Hi!';
    dataDisplayController.text = 'Loading...';
    getSharedPreferences();
  }

  getSharedPreferences() async {
    this.preferences = await SharedPreferences.getInstance();
    String userString = preferences.getString('user');
    this.userInfo = UserInfo.fromJson(jsonDecode(userString));
    nameController.text = 'Hi, ' + userInfo.firstName + '!';
    dataDisplayController.text = userInfo.toString();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        decoration: BoxDecoration(color: Color(0xFFFFFFFF)),
        child: Column(
          children: [
            Container(height: 32.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                widgetSettings(),
                // IconButton(
                //   icon: Icon(
                //     Icons.settings,
                //     color: Theme.of(context).primaryColor,
                //   ),
                //   onPressed: () {
                //     setState(() {
                //       Scaffold.of(context).showSnackBar(SnackBar(
                //         content: Text('Settings'),
                //       ));
                //     });
                //   },
                // )
              ],
            ),
            widgetLogo(),
            Spacer(),
            widgetName(),
            Spacer(),
            widgetStartMeasurement(),
            Spacer(flex: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                widgetBMIIndex(),
              ],
            )
            // widgetUserInfoDebug(),
          ],
        ));
  }

  widgetSettings() {
    return RaisedButton(
      padding: EdgeInsets.all(8.0),
      child: Icon(
        Icons.settings,
        color: Theme.of(context).primaryColor,
      ),
      shape: CircleBorder(),
      elevation: 0.0,
      // splashColor: Theme.of(context).accentColor,
      color: Colors.white,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SettingsPage()),
        );
      },
    );
  }

  widgetLogo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32.0),
      color: Theme.of(context).primaryColor,
      child: Image.asset('assets/images/logo_body_tune.jpeg'),
    );
  }

  widgetName() {
    return TextField(
      controller: nameController,
      readOnly: true,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      style: TextStyle(
          fontSize: 36,
          color: Theme.of(context).accentColor,
          fontFamily: 'Arial',
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold),
    );
  }

  widgetStartMeasurement() {
    return SizedBox(
      height: 220.0,
      width: 220.0,
      child: RaisedButton(
        elevation: 10,
        shape: CircleBorder(),
        splashColor: Theme.of(context).accentColor,
        color: Theme.of(context).primaryColor,
        child: Text(
          'Start\nMeasurement',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontFamily: 'Arial',
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
        ),
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BluetoothCheckPage()),
          );
        },
      ),
    );
  }

  widgetUserInfoDebug() {
    return TextField(
      controller: dataDisplayController,
    );
  }

  widgetBMIIndex() {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: RaisedButton(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'BMI',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(15.0)),
        elevation: 0.0,
        splashColor: Theme.of(context).accentColor,
        color: CustomColor().primary,
        onPressed: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => BMICalcPage()),
          // );

          checkFile();
        },
      ),
    );
  }

  void checkFile() async {
    var bytes;
    List<String> bytesListString = [];
    List<int> bytesListInt = [];
    Uint8List bytesUint8;
    Uint32List bytesUint32;
    String tempPath, filePath;
    try {
      Directory tempDir = await getTemporaryDirectory();
      tempPath = tempDir.path;
      filePath = tempPath + '/your_file_copy.wav';

      // bytes = await rootBundle.load('assets/wav/output.wav');
      // bytes4 = await bytes.buffer.asUint8List();

      bytes = await rootBundle.loadString('assets/wav/outputUint32.txt');
      bytesListString = await (bytes.split(', '));
      for (String s in bytesListString) {
        bytesListInt.add(int.parse(s));
      }

      bytesListInt.insert(0, 77);
      bytesListInt.removeAt(1);

      bytesUint32 = Uint32List.fromList(bytesListInt);

      // File fileWav = await File(filePath).writeAsBytes(bytes4);
      // File fileString =
      //     await File(tempPath + '/outputUint32.wav').writeAsBytes(bytesUint32);
      // print("Home Content: File saved");

      // final StorageReference storageRef =
      //     FirebaseStorage.instance.ref().child('potato.wav');
      // final StorageUploadTask uploadTask = storageRef.putFile(
      //   fileWav,
      // );
      // await uploadTask.onComplete;
      // print("Home Content: Upload Complete");
      // final StorageFileDownloadTask downloadTask =
      //     storageRef.writeToFile(File(tempPath + "/hamza.wav"));
    } catch (e) {
      print(e);
    }

    // bytes4 = Uint8List.fromList(bytes3);
    // File(filePath).writeAsBytes(bytes4);
    // File(tempPath + '/you_file_copy.txt').writeAsString(bytes4.toString());
    // print("Home Content: File saved");

    // debugPrint('HomePage: ' + bytes.buffer.asUint32List().toString());
    debugPrint('HomePage: ' + bytes.toString());
    debugPrint('HomePage: ' + bytesListString.toString());
    debugPrint('HomePage: ' + bytesListInt.toString());
    debugPrint('HomePage: ' + bytesUint32.toString());
  }
}
