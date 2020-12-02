import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:education/data/repositories/repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'geolocation_event.dart';
part 'geolocation_state.dart';

class GeolocationBloc extends Bloc<GeolocationEvent, GeolocationState> {
  final GeolocationRepository geolocationRepository;

  Position currentPosition;

  GeolocationBloc({
    this.geolocationRepository,
  })  : assert(geolocationRepository != null),
        super(GeolocationInitial());

  @override
  Stream<GeolocationState> mapEventToState(GeolocationEvent event) async* {
    if (event is GeolocationInitial) {
      currentPosition = await geolocationRepository.getCurrentLocation();
      yield GeolocationLoadInProgress();
    }

    if (event is GeolocationRequested) {
      yield GeolocationLoadInProgress();

      try {
        currentPosition = await geolocationRepository.getCurrentLocation();

        yield GeolocationLoadSuccess(position: currentPosition);
      } catch (_) {
        yield GeolocationLoadFailure();
      }
    }
  }
}
