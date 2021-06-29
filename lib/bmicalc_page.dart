import 'package:body_tune/helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BMICalcPage extends StatefulWidget {
  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<BMICalcPage> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _resultController = TextEditingController();

  String _result;
  SharedPreferences preferences;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPreferences();
  }

  getSharedPreferences() async {
    this.preferences = await SharedPreferences.getInstance();
    setState(() {
      _result = preferences.getString(SPText().bmi);
    });

    _resultController.text = '0.00';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
        backgroundColor: CustomColor().primary,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              style: textBody1(context),
              decoration: InputDecoration(
                labelText: 'Height in cm',
                labelStyle: textBody1(context),
                icon: Icon(Icons.emoji_people),
                // fillColor: CustomColor().primary,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              style: textBody1(context),
              decoration: InputDecoration(
                labelStyle: textBody1(context),
                labelText: 'Weight in kg',
                icon: Icon(Icons.line_weight),
              ),
            ),
            SizedBox(height: 25),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 60.0),
              child: TextFormField(
                controller: _resultController,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  // fontWeight: FontWeight.bold,
                ),
                cursorColor: CustomColor().primary,
                enabled: false,
                decoration: InputDecoration(
                  labelText: 'Result',
                  labelStyle: TextStyle(
                    color: CustomColor().text,
                    fontSize: 20.0,
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: CustomColor().accent, width: 2.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  _resultController.text == null
                      ? "Last BMI Index: N/A"
                      : "Last BMI Index: $_result",
                  style: TextStyle(
                    color: CustomColor().text,
                    // fontSize: 24.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            RaisedButton(
              color: Theme.of(context).accentColor,
              splashColor: Theme.of(context).primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 36.0, vertical: 12.0),
              child: Text(
                "Calculate",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: calculateBMI,
            ),
          ],
        ),
      ),
    );
  }

  void calculateBMI() {
    double height = double.parse(_heightController.text) / 100;
    double weight = double.parse(_weightController.text);

    FocusScope.of(context).unfocus();

    _heightController.clear();
    _weightController.clear();

    double heightSquare = height * height;
    double result = weight / heightSquare;
    _resultController.text = result.toStringAsFixed(2);
    setState(() {
      _result = result.toStringAsFixed(2);
    });
    preferences.setString(SPText().bmi, result.toStringAsFixed(2));
  }
}
