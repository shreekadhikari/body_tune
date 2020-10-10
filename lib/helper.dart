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
  List<String> dummyList = <String>['1', '2', '3', '4', '5', '6', '7', '8'];
  List<String> daysInWeek = <String>[
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    'Don\'t Know'
  ];
  List<String> hoursInDays = <String>[
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    'Don\'t Know'
  ];
  List<String> activitiesQues = <String>[
    'During the last 7 days, on how many days did you do vigorous physical activities like heavy lifting, digging, aerobics or fast bicycling?',
    'How much time did you  usually spend doing vigorous physical activities on one of the day?',
    'During the last 7 days, on how many days did you do moderate physical activities like carrying light loads, bicycling at a regular pace, or doubles tennis? Do not include walking.',
    'How much time did you usually spend doing moderate physical activities on one of those days?',
    'During the last 7 days, on how many days did you walk for at least 10 minutes at a time?',
    'How much time did you usually spend walking on one of those days?',
    'During the last 7 days. how much time did you spend sitting on a week day?'
  ];
  List<String> activitiesNote = <String>[
    'Think about all the vigorous activities that you did in the last 7 days. Vigorous physical activities refer to activities that take hard physical effort and make you breathe much harder than normal. Think only about those physical activities that you did for at least 10 minutes at a time.',
    '',
    'Think about all the moderate activities that you did in the last 7 days. Moderate activities refer to activities that take take moderate physical effort and make you breathe somewhat harder than normal. Think only about those physical activities that you did for at least 10 minutes at a time.',
    '',
    'Think about the time you spent walking in the last 7 days. This includes at work and at home, walking to travel from place to place, and any other walking that you have done solely for recreation, sport, exercise, or leisure.',
    '',
    'The last question is about the time you spent sitting on weekdays during the last 7 days. Include time spent at work, at home, while doing course work and during leisure time. This may include time spent sitting at a desk, visiting friends, reading, or sitting or lying down to watch television.'
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
