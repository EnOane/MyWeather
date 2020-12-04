import 'package:education/internal/constants.dart';
import 'package:education/logic/geolocation/geolocation_bloc.dart';
import 'package:education/logic/weather/weather_bloc.dart';
import 'package:education/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:responsive_grid/responsive_grid.dart';

class WeatherView extends StatefulWidget {
  const WeatherView({
    Key key,
  }) : super(key: key);

  @override
  _WeatherViewState createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  @override
  void initState() {
    BlocProvider.of<GeolocationBloc>(context).add(GeolocationRequested());
    super.initState();
  }

  Position _position;

  Future<void> _onRefresh() async {
    BlocProvider.of<WeatherBloc>(context).add(
      WeatherRequested(
        lat: _position.latitude,
        lng: _position.longitude,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      backgroundColor: Theme.of(context).primaryColor,
      child: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blueGrey,
              Colors.grey[350],
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                BlocBuilder<GeolocationBloc, GeolocationState>(
                  builder: (context, state) {
                    if (state is GeolocationLoadSuccess) {
                      _position = state.position;

                      BlocProvider.of<WeatherBloc>(context).add(
                        WeatherRequested(
                          lat: _position.latitude,
                          lng: _position.longitude,
                        ),
                      );
                    }

                    if (state is GeolocationLoadFailure) {
                      final snackBar = SnackBar(
                        duration: Duration(seconds: 5),
                        content: Text(
                          'Something went wrong!',
                        ),
                        action: SnackBarAction(
                          label: "CANCEL",
                          onPressed: () => {},
                        ),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      return Center(
                        child: Container(
                          child: Text(state.error.toString()),
                        ),
                      );
                    }

                    return Container();
                  },
                ),
                BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if (state is WeatherLoadInProgress) {
                      return Container(
                        height: MediaQuery.of(context).size.height - 100,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    if (state is WeatherLoadSuccess) {
                      final weather = state.weather;

                      return Padding(
                        padding:
                            const EdgeInsets.only(top: kDefaultPadding * 4),
                        child: ResponsiveGridRow(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ResponsiveGridCol(
                              lg: 12,
                              child: ResponsiveGridRow(
                                children: [
                                  ResponsiveGridCol(
                                    lg: 12,
                                    xs: 12,
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: WeatherMainInfo(
                                        weather: weather,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ResponsiveGridCol(
                              lg: 12,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: kDefaultPadding * 6),
                                child: WeatherViewInfo(weather: weather),
                              ),
                            ),
                            ResponsiveGridCol(
                              child: ResponsiveGridRow(
                                children: [
                                  ResponsiveGridCol(
                                    sm: 1,
                                    md: 2,
                                    lg: 3,
                                    xl: 4,
                                    child: Container(),
                                  ),
                                  ResponsiveGridCol(
                                    xs: 12,
                                    sm: 10,
                                    md: 8,
                                    lg: 6,
                                    xl: 4,
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          top: kDefaultPadding * 8),
                                      child: WeatherMoreInfo(weather: weather),
                                    ),
                                  ),
                                  ResponsiveGridCol(
                                    sm: 1,
                                    md: 2,
                                    lg: 3,
                                    xl: 4,
                                    child: Container(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    if (state is WeatherLoadFailure) {
                      final snackBar = SnackBar(
                        duration: Duration(seconds: 5),
                        content: Text(
                          'Something went wrong!',
                        ),
                        action: SnackBarAction(
                          label: "CANCEL",
                          onPressed: () => {},
                        ),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      return Center(
                        child: Container(
                          child: Text(state.error.toString()),
                        ),
                      );
                    }

                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WeatherMainInfo extends StatelessWidget {
  final Weather weather;

  WeatherMainInfo({
    Key key,
    @required this.weather,
  })  : assert(weather != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final String temp = (weather.temp - 273).ceil().toString();

    return Column(
      children: [
        Image(
          color: Colors.white,
          image: Image.network(
            'https://openweathermap.org/img/wn/${weather.icon}@2x.png',
          ).image,
          height: 80.0,
        ),
        Container(
          child: Text(
            '$temp° C',
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: kDefaultPadding),
          child: Text(
            weather.main,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: kDefaultPadding),
          child: Text(
            'Feels like: ${(weather.feelsLike - 273).ceil()}° C',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.white70),
          ),
        ),
      ],
    );
  }
}

class WeatherViewInfo extends StatelessWidget {
  const WeatherViewInfo({
    Key key,
    @required this.weather,
  }) : super(key: key);

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          weather.name,
          style: Theme.of(context).textTheme.headline4,
        ),
        Padding(
          padding: const EdgeInsets.only(top: kDefaultPadding),
          child: Text(
            'Updated: ${TimeOfDay.fromDateTime(weather.lastUpdated).format(context)}',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.white70),
          ),
        ),
      ],
    );
  }
}

class WeatherMoreInfo extends StatelessWidget {
  const WeatherMoreInfo({
    Key key,
    @required this.weather,
  }) : super(key: key);

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return ResponsiveGridRow(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ResponsiveGridCol(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(kDefaultPadding * 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        'Pressure',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Container(
                      child: Text(
                        weather.pressure.toString(),
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(kDefaultPadding * 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        'Wind speed',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Container(
                      child: Text(
                        '${weather.wind['speed'].toString()} м/с',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(kDefaultPadding * 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        'Humidity',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Container(
                      child: Text(
                        '${weather.humidity.toString()} %',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
