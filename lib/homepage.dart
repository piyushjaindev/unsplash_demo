import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'file:///C:/Users/Ghost%20Rider/AndroidStudioProjects/unsplash_demo/lib/tabview.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index;
  List<Widget> pages;

  @override
  void initState() {
    pages = [TabView(1580860), TabView(139386)];
    index = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50.0,
              child: CupertinoSlidingSegmentedControl(
                children: {
                  0: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text('Collection 1'),
                  ),
                  1: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text('Collection 2'),
                  )
                },
                padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                groupValue: index,
                onValueChanged: (i) {
                  setState(() {
                    index = i;
                  });
                },
              ),
            ),
            Expanded(
                child: IndexedStack(
              children: pages,
              index: index,
            ))
          ],
        ),
      ),
    );
  }
}
