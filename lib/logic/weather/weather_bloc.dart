import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:education/data/repositories/weather.repository.dart';
import 'package:education/models/weather.model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({
    @required this.weatherRepository,
  })  : assert(weatherRepository != null),
        super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is WeatherRequested) {
      yield WeatherLoadInProgress();

      try {
        final Weather weather = await weatherRepository.getWeather(
          lat: event.lat,
          lng: event.lng,
        );

        yield WeatherLoadSuccess(weather: weather);
      } catch (error) {
        yield WeatherLoadFailure(error: error);
      }
    }

    if (event is WeatherRefreshRequested) {
      yield WeatherLoadInProgress();

      try {
        final Weather weather = await weatherRepository.getWeather(
          lat: event.lat,
          lng: event.lng,
        );

        yield WeatherLoadSuccess(weather: weather);
      } catch (error) {
        yield WeatherLoadFailure(error: error);
      }
    }
  }
}
