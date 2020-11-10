import 'dart:convert';
import 'package:body_tune/helper.dart';
import 'package:body_tune/more_info_page.dart';
import 'package:body_tune/settings_page.dart';
import 'package:body_tune/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ContentMain();
  }
}

class _ContentMain extends State<RegisterPage> {
  TextEditingController fnameController, dateController, heightController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fnameController = TextEditingController();
    dateController = TextEditingController();
    heightController = TextEditingController();
//    _ref = FirebaseDatabase.instance.reference().child('userdetail');
  }

  final _formKey = GlobalKey<FormState>();
  String _dropDownGender;
  String _dropDownSmoke;
  String _dropDownActive;
  String _selectedDate;
  int _selectedHeight;

//  DatabaseReference _ref;

  Future _selectDate() async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDatePickerMode: DatePickerMode.year,
        initialDate: new DateTime(2000),
        firstDate: new DateTime(1975),
        lastDate: new DateTime(2010));
    if (picked != null)
      setState(() {
        _selectedDate = DateFormat.yMd().format(picked).toString();
        dateController.text = _selectedDate;
        FocusScope.of(context).requestFocus(new FocusNode());
      });
  }

  storeInSharedPreferences(String key, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Register Page',
            // style: textHeading1(context),
          ),
          bottomOpacity: 0.0,
          automaticallyImplyLeading: false),
      backgroundColor: CustomColor().alternateBackground,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(color: CustomColor().background),
          padding: EdgeInsets.all(28.0),
          margin: EdgeInsets.all(40.0),
          child: Form(
            onWillPop: () async {
              return SystemChannels.platform
                  .invokeMethod('SystemNavigator.pop');
            },
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _widgetFirstName(),
                _widgetDOB(),
                _widgetGender(),
                _widgetSmoke(),
                _widgetHeight(),
                Spacer(),
                _widgetRegisterNext(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _widgetFirstName() {
    return TextFormField(
      controller: fnameController,
      style: textBody1(context),
      decoration: InputDecoration(
        labelText: 'First Name',
        labelStyle: textBody1(context),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return CustomText().emptyMessage1;
        }
        return null;
      },
    );
  }

  _widgetDOB() {
    return TextFormField(
      controller: dateController,
      readOnly: true,
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(
        labelText: 'Date of Birth',
        labelStyle: textBody1(context),
      ),
      onTap: () {
        _selectDate();
      },
      validator: (value) {
        if (value.isEmpty) {
          return CustomText().emptyMessage1;
        }
        return null;
      },
    );
  }

  _widgetGender() {
    return DropdownButtonFormField<String>(
      value: _dropDownGender,
      decoration: InputDecoration(
        labelText: 'Gender',
        labelStyle: textBody1(context),
      ),
      style: textBody1(context),
      validator: (value) {
        if (_dropDownGender == null) {
          return CustomText().emptyMessage1;
        }
        return null;
      },
      onChanged: (String newValue) {
        setState(() {
          _dropDownGender = newValue;
        });
      },
      items:
          CustomText().genderList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  _widgetSmoke() {
    return DropdownButtonFormField<String>(
      value: _dropDownSmoke,
      decoration: InputDecoration(
        labelText: 'Do you smoke?',
        labelStyle: textBody1(context),
        // border: OutlineInputBorder(),
      ),
      style: textBody1(context),
      onChanged: (String newValue) {
        setState(() {
          _dropDownSmoke = newValue;
        });
      },
      validator: (value) {
        if (value == null) {
          return CustomText().emptyMessage1;
        }
        return null;
      },
      items:
          CustomText().smokeList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  _widgetHeight() {
    return TextFormField(
      controller: heightController,
      style: textBody1(context),
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Height',
        labelStyle: textBody1(context),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return CustomText().emptyMessage1;
        }
        return null;
      },
      onTap: _showDialog,
    );
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return NumberPickerDialog.integer(
            title: Text(CustomText().heightDialogTitle),
            minValue: 125,
            maxValue: 225,
            initialIntegerValue: 175,
          );
        }).then((value) {
      // setState(() {
      _selectedHeight = value;
      heightController.text = _selectedHeight.toString();
      FocusScope.of(context).requestFocus(new FocusNode());
      // });
    });
  }

  _widgetRegisterNext() {
    return RaisedButton(
      splashColor: Theme.of(context).primaryColor,
      child: Text(
        'Next',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () async {
        // color: Theme.of(context).accentColor,
        // if (_formKey.currentState.validate()) {
//        saveuserdetail();
        if (true) {
          UserInfo newUser = UserInfo(fnameController.text, dateController.text,
              _dropDownGender, _dropDownSmoke, _selectedHeight.toString());

          debugPrint('RegisterPage User: ' + newUser.toString());

          String userString = jsonEncode(newUser);

          debugPrint('RegisterPage UserJSON: ' + userString);

          UserInfo testUser = UserInfo.fromJson(jsonDecode(userString));

          debugPrint('RegisterPage TestUser: ' + testUser.toString());

          storeInSharedPreferences(SPText().user, userString);
          storeInSharedPreferences(SPText().normalBreathing, '1');
          storeInSharedPreferences(SPText().guidedBreathing, '2');
          storeInSharedPreferences(SPText().coughing, '3');
          storeInSharedPreferences(SPText().swallowing, '4');
          storeInSharedPreferences(SPText().apnea, '5');

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MoreInfoPage()),
          );
        }
      },
    );
  }

//  void saveuserdetail(){
//  String name = fnameController.text;
//  String date = dateController.text;
//  String height = heightController.text;

//  Map<String,String> userdetail = {
//    'name':name,
//    'date':date,
//    'height': height,
//  };

//  _ref.push().set(userdetail).then((value) {
//  });

//  }
}
