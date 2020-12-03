import 'package:education/internal/constants.dart';
import 'package:education/logic/geolocation/geolocation_bloc.dart';
import 'package:education/logic/weather/weather_bloc.dart';
import 'package:education/presentation/widgets/home/weather.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        toolbarHeight: 80.0,
        elevation: 3.0,
        title: Row(
          children: [
            Container(
              child: Image(
                color: Colors.white,
                image: Image.asset('assets/icons/icon.png').image,
                width: 50.0,
                height: 50.0,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: kDefaultPadding * 2),
              child: Text(
                'MyWeather',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        actions: [
          Container(
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: kDefaultPadding * 1.5),
                  child: IconButton(
                    tooltip: 'Refresh',
                    icon: Icon(Icons.refresh),
                    color: Colors.white,
                    onPressed: () {
                      var currentPosition =
                          BlocProvider.of<GeolocationBloc>(context)
                              .currentPosition;

                      if (currentPosition == null) {
                        BlocProvider.of<GeolocationBloc>(context)
                            .add(GeolocationRequested());
                      } else {
                        BlocProvider.of<WeatherBloc>(context).add(
                          WeatherRequested(
                            lat: currentPosition.latitude,
                            lng: currentPosition.longitude,
                          ),
                        );
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: kDefaultPadding * 1.5),
                  child: IconButton(
                    tooltip: 'Settings',
                    icon: Icon(Icons.settings),
                    color: Colors.white,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body: WeatherView(),
    );
  }
}
