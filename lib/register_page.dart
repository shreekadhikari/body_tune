import 'package:body_tune/helper.dart';
import 'package:body_tune/more_info_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ContentMain();
  }
}

class _ContentMain extends State<RegisterPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  String _dropDownGender;
  String _dropDownSmoke;
  String _dropDownActive;
  String _selectedDate;
  int _selectedHeight;

  final dateController = TextEditingController();
  final heightController = TextEditingController();

  Future _selectDate() async {
    final DateTime picked = await showDatePicker(
        context: context,
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
      backgroundColor: Color(0xFFD9D2D5),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(color: Color(0xFFFFFFFF)),
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
                _widgetFitness(),
                Expanded(child: Container()),
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
      style: textBody1(context),
      decoration: InputDecoration(
        labelText: 'First Name',
        labelStyle: textBody1(context),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'This field is necessary';
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
          return 'This field is necessary';
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
          return 'This field is necessary';
        }
        return null;
      },
      onChanged: (String newValue) {
        setState(() {
          _dropDownGender = newValue;
        });
      },
      items: <String>['Male', 'Female', 'Others']
          .map<DropdownMenuItem<String>>((String value) {
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
          return 'This field is necessary';
        }
        return null;
      },
      items:
          <String>['Yes', 'No'].map<DropdownMenuItem<String>>((String value) {
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
          return 'This field is necessary';
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

  _widgetFitness() {
    return DropdownButtonFormField<String>(
      value: _dropDownActive,
      decoration: InputDecoration(
        labelText: 'Rate yourself for fitness',
        labelStyle: textBody1(context),
        // border: OutlineInputBorder(),
      ),
      style: textBody1(context),
      onChanged: (String newValue) {
        setState(() {
          _dropDownActive = newValue;
        });
      },
      validator: (value) {
        if (value == null) {
          return 'This field is necessary';
        }
        return null;
      },
      items: <String>[
        'Sedentary',
        'Low active',
        'Somewhat Active',
        'Active',
        'Very Active'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  _widgetRegisterNext() {
    return RaisedButton(
      splashColor: Theme.of(context).primaryColor,
      child: Text(
        'Next',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      color: Theme.of(context).accentColor,
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          // if (true) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MoreInfoPage()),
          );
        }
      },
    );
  }
}
