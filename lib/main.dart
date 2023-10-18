import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WeatherApp(),
    );
  }
}

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  final apiKey = '';
  final city = 'Lamongan';

  Future<Map<String, dynamic>?> fetchWeather() async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cuaca di $city'),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: fetchWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError || snapshot.data == null) {
            return Text('Error: ${snapshot.error}');
          } else {
            final weatherData = snapshot.data!;
            final weatherDescription =
                weatherData['weather']?[0]['description'] ?? 'Not Available';
            final temperatureKelvin =
                (weatherData['main']?['temp'] ?? 0).toDouble();
            final temperatureCelsius = temperatureKelvin - 273.15;
            final temperatureCelsiusString =
                temperatureCelsius.toStringAsFixed(2);

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/moon.png',
                    width: 200,
                    height: 200,
                  ),
                  Text(
                    '$city',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '$temperatureCelsiusString °C',
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    '$weatherDescription',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
