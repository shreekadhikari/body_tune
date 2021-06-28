import 'package:body_tune/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SummaryContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ContentMain();
  }
}

class _ContentMain extends State<SummaryContent> {
  SharedPreferences preferences;

  List<String> listResult = [];
  List<String> listDate = [];

  @override
  Widget build(BuildContext context) {
    sharedPreferences();

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Summary'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: listResult.length == null ? 0 : listResult.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 0.0),
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date: ' + listDate[index],
                          style: textBody1(context),
                        ),
                        Container(
                          height: 8.0,
                        ),
                        Text(
                          'Heart Rate: ' + listResult[index],
                          style: textHeading1(context),
                        ),
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

  void sharedPreferences() async {
    this.preferences = await SharedPreferences.getInstance();
    setState(() {
      listResult = preferences.getStringList(SPText().testResultList);
      listDate = preferences.getStringList(SPText().testDateList);
    });
  }
}
