part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class WeatherRequested extends WeatherEvent {
  final double lat;
  final double lng;

  const WeatherRequested({
    @required this.lat,
    @required this.lng,
  }) : assert(lat != null && lng != null);

  @override
  List<Object> get props => [lat, lng];
}

class WeatherRefreshRequested extends WeatherEvent {
  final double lat;
  final double lng;

  const WeatherRefreshRequested({
    @required this.lat,
    @required this.lng,
  }) : assert(lat != null && lng != null);

  @override
  List<Object> get props => [lat, lng];
}
