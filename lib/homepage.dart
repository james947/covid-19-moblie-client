import 'package:covid_tracker/pages/countryPage.dart';
import 'package:covid_tracker/panels/infoPanel.dart';
import 'package:covid_tracker/panels/mostaffectedcountries.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:covid_tracker/datasource.dart';
import 'package:covid_tracker/panels/worldwidepanel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map worldData;

  fetchWorldWideData() async {
    http.Response response = await http.get('https://corona.lmao.ninja/all');

    setState(() {
      worldData = jsonDecode(response.body);
    });
  }

  List countryData;

  fetchCountryData() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/countries?sort=cases');

    setState(() {
      countryData = jsonDecode(response.body);
    });
  }

  @override
  void initState() {
    fetchWorldWideData();
    fetchCountryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: Icon(Theme.of(context).brightness == Brightness.light? Icons.lightbulb_outline : Icons.highlight), onPressed:(){
            DynamicTheme.of(context).setBrightness(Theme.of(context).brightness == Brightness.light? Brightness.dark : Brightness.light);
          } ,)
        ],
        centerTitle: false,
        title: Text('Covid-19 Tracker'),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 100,
            alignment: Alignment.center,
            padding: EdgeInsets.all(5.0),
            color: Colors.orange[100],
            child: Text(
              DataSource.quote,
              style: TextStyle(
                  color: Colors.orange[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'WorldWide',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CountryPage()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark? Colors.grey[100] : Colors.grey[900],
                        borderRadius: BorderRadius.circular(10.0)),
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Regional',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).brightness == Brightness.dark? Colors.grey[900] : Colors.white,
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          worldData == null
              ? CircularProgressIndicator()
              : WorldWidePanel(
                  worldData: worldData,
                ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              'Most Affected Countries',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          countryData == null
              ? Container()
              : MostAffectedPanel(
                  countryData: countryData,
                ),
          SizedBox(height: 10.0),
          InfoPanel(),
          SizedBox(
            height: 20.0,
          ),
          Center(
              child: Text(
            'WE ARE TOGETHER IN THE FIGHT',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
          )),
          SizedBox(
            height: 50.0,
          )
        ],
      )),
    );
  }
}
