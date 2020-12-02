import 'dart:async';

import 'package:education/data/providers/providers.dart';
import 'package:education/models/weather.model.dart';

class WeatherRepository {
  final WeatherApiClient weatherApiClient = WeatherApiClient();

  Future<Weather> getWeather({double lat, double lng}) async {
    var weather = await weatherApiClient.fetchWeather(lat: lat, lng: lng);
    return Weather.fromJSON(weather);
  }
}
