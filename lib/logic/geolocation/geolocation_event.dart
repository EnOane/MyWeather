part of 'geolocation_bloc.dart';

abstract class GeolocationEvent extends Equatable {
  const GeolocationEvent();
}

class GeolocationRequested extends GeolocationEvent {
  GeolocationRequested();

  @override
  List<Object> get props => [];
}
