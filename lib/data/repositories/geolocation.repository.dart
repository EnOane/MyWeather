import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class GeolocationRepository {
  Future<Position> getCurrentLocation() async {
    Position _position;

    if (kIsWeb) {
      _position = Position(latitude: 35.0, longitude: 113.0);
    } else if (Platform.isAndroid) {
      final bool _serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (_serviceEnabled) {
        LocationPermission permission = await Geolocator.checkPermission();

        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          LocationPermission answer = await Geolocator.requestPermission();

          if (answer != LocationPermission.denied ||
              answer != LocationPermission.deniedForever) {
            _position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high,
            );
          }
        } else {
          _position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);
        }
      } else if (_serviceEnabled == false) {
        Position pos = await Geolocator.getLastKnownPosition();

        if (pos != null) {
          _position = pos;
        }
      }
    }

    return _position;
  }
}
