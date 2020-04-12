import 'package:covid_tracker/panels/mostaffectedcountries.dart';
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

  fetchWorldWideData() async{


    http.Response response = await http.get('https://corona.lmao.ninja/all');

    setState(() {
      worldData = jsonDecode(response.body);
    });
  }

  List countryData;

  fetchCountryData() async{
    http.Response response = await http.get('https://corona.lmao.ninja/countries');

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
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
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
                Container(
                  decoration: BoxDecoration(
                    color: primaryBlack,
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Regional',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 22.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          worldData == null? CircularProgressIndicator() : WorldWidePanel( worldData: worldData,),
          SizedBox(height: 10.0,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(
              'Most Affected Countries',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
              ),
            ),
          ),
          SizedBox(height: 10.0,),
          countryData==null?  Container() : MostAffectedPanel(countryData: countryData,),
        ],
      )),
    );
  }
}
