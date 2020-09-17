import 'package:flutter/material.dart';

class CustomColor {
  Color primary = Color(0xFF769976);
  Color accent = Color(0xFFB37166);
  Color text = Color(0xFF4D4B4C);
  Color background = Color(0xFFFFFFFF);
  Color alternateBackground = Color(0xFFD9D2D5);
}

class CustomText {
  String heightDialogTitle = 'Height is cm';
  String fitness = 'Rate yourself for fitness';
  String emptyMessage1 = 'This field is necessary';
  String logoLocation = 'assets/images/logo_body_tune.jpeg';
  List<String> genderList = <String>['Male', 'Female', 'Others'];
  List<String> smokeList = <String>['Yes', 'No'];
  List<String> fitnessList = <String>[
    'Sedentary',
    'Low active',
    'Somewhat Active',
    'Active',
    'Very Active'
  ];
}

textBody1(BuildContext context) {
  return Theme.of(context).textTheme.bodyText1;
}

textBody2(BuildContext context) {
  return Theme.of(context).textTheme.bodyText2;
}

textHeading1(BuildContext context) {
  return Theme.of(context).textTheme.headline1;
}

textHeading2(BuildContext context) {
  return Theme.of(context).textTheme.headline2;
}

showSnackBar(BuildContext context, String string) {
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text(string),
  ));
}
