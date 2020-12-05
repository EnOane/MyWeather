import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  /// Group of weather parameters (Rain, Snow, Extreme etc.)
  final String main;

  /// Weather condition within the group. You can get the output in your language.
  final String description;

  /// Icon
  final String icon;

  /// Temperature. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
  final double temp;

  /// Temperature. This temperature parameter accounts for the human perception of weather.
  /// Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
  final double feelsLike;

  /// Atmospheric pressure (on the sea level, if there is no sea_level or grnd_level data), hPa
  final int pressure;

  /// Humidity, %
  final int humidity;

  /// Wind speed. Unit Default: meter/sec, Metric: meter/sec, Imperial: miles/hour.
  final Map<String, dynamic> wind;

  /// Последнее обновление
  final DateTime lastUpdated = DateTime.now();

  /// City name
  final String name;

  Weather({
    this.main,
    this.description,
    this.icon,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.wind,
    this.name,
  });

  static Weather fromJSON(Map<String, dynamic> map) {
    return Weather(
      main: map['weather'][0]['main'],
      description: map['weather'][0]['description'],
      icon:
          'https://openweathermap.org/img/wn/${map['weather'][0]['icon']}@2x.png',
      temp: map['main']['temp'],
      feelsLike: map['main']['feels_like'],
      pressure: map['main']['pressure'],
      humidity: map['main']['humidity'],
      wind: map['wind'],
      name: map['name'],
    );
  }

  @override
  List<Object> get props => [
        main,
        description,
        icon,
        temp,
        feelsLike,
        pressure,
        humidity,
        wind,
        lastUpdated,
        name,
      ];
}

enum WeatherCondition {
  snow,
  sleet,
  hail,
  thunderstorm,
  heavyRain,
  lightRain,
  showers,
  heavyCloud,
  lightCloud,
  clear,
  unknown
}
