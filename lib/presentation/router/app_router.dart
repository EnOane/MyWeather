import 'package:education/data/repositories/repositories.dart';
import 'package:education/data/repositories/weather.repository.dart';
import 'package:education/logic/geolocation/geolocation_bloc.dart';
import 'package:education/logic/weather/weather_bloc.dart';
import 'package:education/presentation/screens/home.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  final WeatherRepository weatherRepository = WeatherRepository();
  final GeolocationRepository geolocationRepository = GeolocationRepository();

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<WeatherBloc>(
                create: (BuildContext context) => WeatherBloc(
                  weatherRepository: weatherRepository,
                ),
              ),
              BlocProvider<GeolocationBloc>(
                create: (BuildContext context) => GeolocationBloc(
                  geolocationRepository: geolocationRepository,
                ),
              ),
            ],
            child: HomeScreen(),
          ),
        );
        break;

      default:
        return null;
    }
  }
}
