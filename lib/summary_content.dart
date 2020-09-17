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
  List<String> bpm = ['120', '115', '125', '123', '118'];
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
          // Container(
          //   padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 0.0),
          //   child: Text(
          //     'Summary',
          //     style: TextStyle(
          //         fontSize: 32,
          //         color: Theme.of(context).accentColor,
          //         fontFamily: 'Arial',
          //         fontStyle: FontStyle.italic,
          //         fontWeight: FontWeight.bold),
          //   ),
          // ),
          Expanded(
            child: ListView.builder(
              itemCount: date.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin:
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 12.0),
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date: ' + date[index],
                          style: textBody1(context),
                        ),
                        Container(
                          height: 4.0,
                        ),
                        Text(
                          'Heart Rate: ' + bpm[index],
                          style: textHeading1(context),
                        ),
                        Container(
                          height: 4.0,
                        ),
                        Text(
                          'BMI: ' + bmiIndex[index],
                          style: textHeading2(context),
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
