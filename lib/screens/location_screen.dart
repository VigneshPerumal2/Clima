import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen(this.data);
  final data;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  var cityName;
  int temp;
  String city;
  int id;
  String emoji;
  String desc;
  WeatherModel w = WeatherModel();
  @override
  void initState() {
    super.initState();

    getState(widget.data);
  }

  void getState(dynamic weather) {

    if (weather == Null) {
      setState(() {
        temp = 999;
        city = '';
        emoji = '';
        desc = 'ERROR';
      });
    } else {
      setState(() {
        double x = weather['main']['temp'];
        temp = x.round();
        city = weather['name'];
        id = weather['weather'][0]['id'];
        emoji = w.getWeatherIcon(id);
        desc = w.getMessage(temp);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: ()async {
                      getState(await WeatherModel().getLocationData());
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      cityName= await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      })
                      );
                      WeatherModel w=WeatherModel();
                      var data=await w.getCityData(cityName);
                      if(data!=Null){
                        getState(data);
                      }
                      else{
                        getState(Null);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      temp.toString(),
                      style: kTempTextStyle,
                    ),
                    Text(
                      emoji,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$desc in $city',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
