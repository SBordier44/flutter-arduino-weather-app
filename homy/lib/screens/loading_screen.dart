import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:homy/constants.dart';
import 'package:homy/credentials.dart';
import 'package:homy/screens/main_screen.dart';
import 'package:homy/utils/arduino1.dart';
import 'package:homy/utils/weather.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getWeatherData() async {
    // Fetch the current weather
    WeatherData weatherData =
        WeatherData(longitude: longitude, latitude: latitude);
    await weatherData.getCurrentTemperature();

    Arduino1 arduino1 = Arduino1();
    await arduino1.getCurrentData();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return MainScreen(weatherData: weatherData, arduino1: arduino1);
        },
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: kLinearGradient,
        ),
        child: const Center(
          child: SpinKitRipple(
            color: Colors.white,
            size: 150.0,
            duration: Duration(milliseconds: 1200),
          ),
        ),
      ),
    );
  }
}
