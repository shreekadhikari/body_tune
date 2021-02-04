import 'package:body_tune/helper.dart';
import 'package:body_tune/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ContentMain();
  }
}

class _ContentMain extends State<SettingsPage> {
  SharedPreferences preferences;

  String normalBreathing = '1';
  String guidedBreathing = '1';
  String coughing = '1';
  String swallowing = '1';
  String apnea = '1';

  bool showSetting = false;

  _ContentMain() {
    getSharedPreferences();
  }

  getSharedPreferences() async {
    this.preferences = await SharedPreferences.getInstance();
    normalBreathing = preferences.getString(SPText().normalBreathing);
    guidedBreathing = preferences.getString(SPText().guidedBreathing);
    coughing = preferences.getString(SPText().coughing);
    swallowing = preferences.getString(SPText().swallowing);
    apnea = preferences.getString(SPText().apnea);

    debugPrint('SettingsPage NormalBreathing: ' +
        preferences.getString('normalBreathing'));

    setState(() {
      showSetting = true;
    });
  }

  storeInSharedPreferences(String key, String value) async {
    await preferences.setString(key, value);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      backgroundColor: CustomColor().alternateBackground,
      body: Container(
        margin: EdgeInsets.all(40.0),
        padding: EdgeInsets.all(20.0),
        color: CustomColor().background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _widgetNormalBreathing(),
            _widgetGuidedBreathing(),
            _widgetCoughing(),
            _widgetSwallowing(),
            _widgetApnea(),
            Spacer(),
            Text('All time is in seconds'),
            _widgetSaveButton()
          ],
        ),
      ),
    );
  }

  _widgetNormalBreathing() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: showSetting
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Normal Breathing:',
                    style: textBody1(context),
                  ),
                  flex: 4,
                ),
                Expanded(
                  child: DropdownButton(
                    value: normalBreathing,
                    items: CustomText()
                        .dummyList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        normalBreathing = newValue;
                      });
                    },
                  ),
                  flex: 1,
                )
              ],
            )
          : null,
    );
  }

  _widgetGuidedBreathing() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: showSetting
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Guided Breathing:',
                    style: textBody1(context),
                  ),
                  flex: 4,
                ),
                Expanded(
                  child: DropdownButton(
                    value: guidedBreathing,
                    items: CustomText()
                        .dummyList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        guidedBreathing = newValue;
                      });
                    },
                  ),
                  flex: 1,
                )
              ],
            )
          : null,
    );
  }

  _widgetCoughing() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: showSetting
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Coughing:',
                    style: textBody1(context),
                  ),
                  flex: 4,
                ),
                Expanded(
                  child: DropdownButton(
                    value: coughing,
                    items: CustomText()
                        .dummyList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        coughing = newValue;
                      });
                    },
                  ),
                  flex: 1,
                )
              ],
            )
          : null,
    );
  }

  _widgetSwallowing() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: showSetting
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Swallowing:',
                    style: textBody1(context),
                  ),
                  flex: 4,
                ),
                Expanded(
                  child: DropdownButton(
                    value: swallowing,
                    items: CustomText()
                        .dummyList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        swallowing = newValue;
                      });
                    },
                  ),
                  flex: 1,
                )
              ],
            )
          : null,
    );
  }

  _widgetApnea() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: showSetting
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Apnea:',
                    style: textBody1(context),
                  ),
                  flex: 4,
                ),
                Expanded(
                  child: DropdownButton(
                    value: apnea,
                    items: CustomText()
                        .dummyList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        apnea = newValue;
                      });
                    },
                  ),
                  flex: 1,
                )
              ],
            )
          : null,
    );
  }

  _widgetSaveButton() {
    return RaisedButton(
      splashColor: Theme.of(context).primaryColor,
      child: Text(
        'Save',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      onPressed: () async {
        storeInSharedPreferences(SPText().normalBreathing, normalBreathing);
        storeInSharedPreferences(SPText().guidedBreathing, guidedBreathing);
        storeInSharedPreferences(SPText().coughing, coughing);
        storeInSharedPreferences(SPText().swallowing, swallowing);
        storeInSharedPreferences(SPText().apnea, apnea);

        Navigator.pop(context);
      },
    );
  }
}
