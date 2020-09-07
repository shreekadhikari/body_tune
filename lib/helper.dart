import 'package:flutter/material.dart';

class CustomColor {
  Color primary = Color(0xFF4D4B4C);
  Color secondary = Color(0xFF769976);
  Color alternate = Color(0xFFD9D2D5);
  Color background = Color(0xFFFFFFFF);
  Color text = Color(0xFFB37166);
}

textBody1(BuildContext context) {
  return Theme.of(context).textTheme.bodyText1;
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
