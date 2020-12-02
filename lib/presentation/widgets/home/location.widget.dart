import 'package:education/models/models.dart';
import 'package:flutter/material.dart';

class Location extends StatelessWidget {
  final Weather weather;

  Location({Key key, @required this.weather})
      : assert(weather != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final String temp = (weather.temp - 273).ceil().toString();

    return Text(
      '$temp° C',
      style: Theme.of(context).textTheme.headline1,
    );
  }
}
