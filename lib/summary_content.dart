import 'package:body_tune/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class SummaryContent extends StatelessWidget {
  List<String> date = [
    '05/02/2020',
    '04/03/2020',
    '06/05/2020',
    '05/06/2020',
    '06/08/2020'
  ];
  List<String> bpm = ['120 bpm', '115 bpm', '125 bpm', '123 bpm', '118 bpm'];
  List<String> bmiIndex = ['24.5', '25', '25.2', '25.4', '24.8'];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: CustomColor().alternateBackground,
      appBar: AppBar(
        title: Text('Summary'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: date.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 0.0),
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date: ' + date[index],
                          style: textBody1(context),
                        ),
                        Container(
                          height: 8.0,
                        ),
                        Text(
                          'Heart Rate: ' + bpm[index],
                          style: textHeading1(context),
                        ),
                        Container(
                          height: 8.0,
                        ),
                        Text(
                          'BMI: ' + bmiIndex[index],
                          style: textBody2(context),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
