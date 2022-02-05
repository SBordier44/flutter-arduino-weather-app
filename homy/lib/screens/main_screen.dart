import 'package:flutter/material.dart';
import 'package:homy/utils/weather.dart';

import '../utils/helpers.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({required this.weatherData, Key? key}) : super(key: key);

  final WeatherData weatherData;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late double temperature;
  late int humidity;
  late String tempDescription;
  late Icon weatherDisplayIcon;
  late AssetImage backgroundImage;

  void updateDisplayInfo(WeatherData weatherData) {
    setState(() {
      temperature = weatherData.currentTemperature;
      humidity = weatherData.currentHumidity;
      tempDescription = weatherData.currentDescription;
      WeatherDisplayData weatherDisplayData =
          weatherData.getWeatherDisplayData();
      backgroundImage = weatherDisplayData.weatherImage;
      weatherDisplayIcon = weatherDisplayData.weatherIcon;
    });
  }

  @override
  void initState() {
    super.initState();
    updateDisplayInfo(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: backgroundImage,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 85,
            ),
            Container(
              child: weatherDisplayIcon,
            ),
            const SizedBox(
              height: 15.0,
            ),
            Center(
              child: Text(
                '${temperature.toStringAsFixed(1)}°',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 80.0,
                  letterSpacing: -5,
                ),
              ),
            ),
            Center(
              child: Text(
                '$humidity%',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 80.0,
                  letterSpacing: -5,
                ),
              ),
            ),
            Center(
              child: Text(
                capitalize(tempDescription),
                style: const TextStyle(color: Colors.white, fontSize: 40.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
