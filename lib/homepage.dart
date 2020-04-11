import 'package:covid_tracker/datasource.dart';
import 'package:covid_tracker/panels/worldwidepanel.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Covid-19 Tracker'),
      ),
      body: SingleChildScrollView(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 100,
            alignment: Alignment.center,
            padding: EdgeInsets.all(5.0),
            color: Colors.orange[100],
            child: Text(
                DataSource.quote,
                style: TextStyle(color: Colors.orange[800], fontWeight: FontWeight.bold, fontSize: 16.0 ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
            child: Text(
                'WorldWide',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
              ),
            ),
          ),
          WorldWidePanel(),
        ],
      )),
    );
  }
}
