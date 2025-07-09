import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import '../models/weather_model.dart';

class WeatherCard extends StatelessWidget {
  final WeatherModel weather;

  const WeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.lightBlue[100],
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              weather.cityName,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            BoxedIcon(WeatherIcons.day_sunny, size: 40),
            Text(
              '${weather.temperature.toStringAsFixed(1)} °C',
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
            ),
            Text(weather.description),
            const SizedBox(height: 10),
            Text('Humidity: ${weather.humidity}%'),
            Text('Wind: ${weather.windSpeed} m/s'),
            Text('Pressure: ${weather.pressure} hPa'),
          ],
        ),
      ),
    );
  }
}
