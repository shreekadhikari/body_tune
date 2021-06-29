import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './home_content.dart';
import './summary_content.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  bool exit = false;
  List<Widget> _children = [HomeContent(), SummaryContent()];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () async {
        if (exit) {
          return SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        }
        exit = true;
        return false;
      },
      child: Scaffold(
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            onTap: onTabTapped,
            selectedItemColor: Theme.of(context).primaryColor,
            currentIndex: _currentIndex,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.update), label: 'Summary')
            ]),
      ),
    );
  }
}
