import 'dart:async';

import 'package:education/data/providers/providers.dart';
import 'package:geolocator/geolocator.dart';

class GeolocationRepository {
  final GeolocationProvider geolocationProvider = GeolocationProvider();

  Future<Position> getCurrentLocation() {
    return geolocationProvider.fetchLocation();
  }
}
