import 'package:flutter/material.dart';
import 'package:homy/utils/arduino1.dart';
import 'package:homy/utils/weather.dart';

import '../utils/helpers.dart';

class MainScreen extends StatefulWidget {
  const MainScreen(
      {required this.weatherData, required this.arduino1, Key? key})
      : super(key: key);

  final Arduino1 arduino1;
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
  late double arduino1Temperature;
  late double arduino1Humidity;

  void updateDisplayInfo(WeatherData weatherData, Arduino1 arduino1) {
    setState(() {
      temperature = weatherData.currentTemperature;
      humidity = weatherData.currentHumidity;
      tempDescription = weatherData.currentDescription;
      WeatherDisplayData weatherDisplayData =
          weatherData.getWeatherDisplayData();
      backgroundImage = weatherDisplayData.weatherImage;
      weatherDisplayIcon = weatherDisplayData.weatherIcon;
      arduino1Temperature = arduino1.currentTemperature;
      arduino1Humidity = arduino1.currentHumidity;
    });
  }

  @override
  void initState() {
    super.initState();
    updateDisplayInfo(widget.weatherData, widget.arduino1);
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
            const Divider(
              thickness: 10,
              color: Colors.white24,
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                  child: Text(
                'Chambre 1',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    decoration: TextDecoration.underline),
              )),
            ),
            Center(
              child: Text(
                '${arduino1Temperature.toStringAsFixed(1)}°',
                style: const TextStyle(color: Colors.white, fontSize: 40.0),
              ),
            ),
            Center(
              child: Text(
                '${arduino1Humidity.toStringAsFixed(1)}%',
                style: const TextStyle(color: Colors.white, fontSize: 40.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
