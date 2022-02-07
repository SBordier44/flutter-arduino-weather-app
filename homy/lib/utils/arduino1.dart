import 'dart:convert';

import 'package:homy/credentials.dart';
import 'package:http/http.dart';

class Arduino1 {
  double currentTemperature = 0.0;
  double currentHumidity = 0.0;

  Future<void> getCurrentData() async {
    Response response = await get(Uri.parse(arduino1Endpoint));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      try {
        currentTemperature = data['temperature'].toDouble();
        currentHumidity = data['humidity'].toDouble();
      } catch (e) {
        print(e);
      }
    } else {
      print('Unable to fetch current Arduino 1 status');
    }
  }
}
