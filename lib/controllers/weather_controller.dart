import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';

class WeatherController with ChangeNotifier {
  final WeatherService _weatherService = WeatherService();
  WeatherModel? _weather;

  WeatherModel? get weather => _weather;
  bool isLoading = false;

  Future<void> loadWeather(String city) async {
    isLoading = true;
    notifyListeners();

    try {
      _weather = await _weatherService.fetchWeather(city);
    } catch (e) {
      print('Error loading weather: $e');
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> loadWeatherFromLocation() async {
    isLoading = true;
    notifyListeners();

    try {
      // Check permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.always &&
            permission != LocationPermission.whileInUse) {
          throw Exception('Location permission denied');
        }
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Call weather API using latitude and longitude
      _weather = await _weatherService.fetchWeatherByLocation(
        position.latitude,
        position.longitude,
      );
    } catch (e) {
      print('Error loading weather from location: $e');
    }

    isLoading = false;
    notifyListeners();
  }
}
