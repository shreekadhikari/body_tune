import 'package:body_tune/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'helper.dart';

class MoreInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ContentMain();
  }
}

class _ContentMain extends State<MoreInfoPage> {
  bool checkBoxDiabetes = false;
  bool checkBoxHypertension = false;
  bool checkBoxCoronary = false;
  bool checkBoxAngioplasty = false;
  bool checkBoxEndarterectomy = false;

  Map<String, bool> values = {
    'Apple': false,
    'Banana': false,
    'Cherry': false,
    'Mango': false,
    'Orange': false,
  };

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register',
        ),
      ),
      backgroundColor: Color(0xFFD9D2D5),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(color: Color(0xFFFFFFFF)),
          padding: EdgeInsets.all(28.0),
          margin: EdgeInsets.all(40.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _widgetTitle(),
                _widgetSubtitle(),
                // _widgetBodyfat(),
                _widgetComorbidities(),
                _widgetDiabeties(),
                _widgetHypertension(),
                _widgetCoronary(),
                _widgetAngioplasty(),
                _widgetEndarterectomy(),
                Spacer(),
                _widgetRegister(),
              ],
              // Column(
            ),
          ),
        ),
      ),
    );
  }

  _widgetTitle() {
    return Container(
      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: Text(
        'Great, You did good!',
        style: textHeading1(context),
      ),
    );
  }

  _widgetSubtitle() {
    return Container(
      padding: EdgeInsets.only(top: 20.0, bottom: 40.0),
      child: Text(
        'Tell us a bit more about you!',
        style: textHeading2(context),
      ),
    );
  }

  _widgetBodyfat() {
    return TextFormField(
      style: textBody1(context),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Body fat level',
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

  _widgetComorbidities() {
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: Text(
        'Comorbidities:',
        style: textBody1(context),
      ),
    );
  }

  _widgetDiabeties() {
    return CheckboxListTile(
      title: Text('Diabetes'),
      value: checkBoxDiabetes,
      onChanged: (newValue) {
        setState(() {
          checkBoxDiabetes = newValue;
        });
      },
    );
  }

  _widgetHypertension() {
    return CheckboxListTile(
      title: Text('Hypertension'),
      value: checkBoxHypertension,
      onChanged: (newValue) {
        setState(() {
          checkBoxHypertension = newValue;
        });
      },
    );
  }

  _widgetCoronary() {
    return CheckboxListTile(
      title: Text('Coronary Disease'),
      value: checkBoxCoronary,
      onChanged: (newValue) {
        setState(() {
          checkBoxCoronary = newValue;
        });
      },
    );
  }

  _widgetAngioplasty() {
    return CheckboxListTile(
      title: Text('Angioplasty'),
      value: checkBoxAngioplasty,
      onChanged: (newValue) {
        setState(() {
          checkBoxAngioplasty = newValue;
        });
      },
    );
  }

  _widgetEndarterectomy() {
    return CheckboxListTile(
      title: Text('Endarterectomy'),
      value: checkBoxEndarterectomy,
      onChanged: (newValue) {
        setState(() {
          checkBoxEndarterectomy = newValue;
        });
      },
    );
  }

  _widgetRegister() {
    return RaisedButton(
      splashColor: Theme.of(context).primaryColor,
      child: Text(
        'Register',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      color: Theme.of(context).accentColor,
      onPressed: () {
        if (_formKey.currentState.validate()) {
          // if (true) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        }
      },
    );
  }
}
