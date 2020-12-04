import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class WeatherApiClient {
  final http.Client _httpClient = http.Client();
  final String _api = 'bc6ba183cf4db1880e293595ff60b5d8';
  final String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<Map<String, dynamic>> fetchWeather({
    @required double lat,
    @required double lng,
  }) async {
    final weatherUrl = '$_baseUrl?lat=$lat&lon=$lng&lang=en&appid=$_api';
    final weatherResponse = await _httpClient.get(weatherUrl);

    if (weatherResponse.statusCode != 200) {
      throw Exception('error getting weather for location');
    }

    return jsonDecode(weatherResponse.body);
  }
}
