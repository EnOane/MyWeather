part of 'geolocation_bloc.dart';

abstract class GeolocationState extends Equatable {
  const GeolocationState();

  @override
  List<Object> get props => [];
}

class GeolocationInitial extends GeolocationState {}

class GeolocationLoadInProgress extends GeolocationState {}

class GeolocationLoadSuccess extends GeolocationState {
  final Position position;

  const GeolocationLoadSuccess({
    this.position,
  }) : assert(position != null);

  @override
  List<Object> get props => [position];
}

class GeolocationLoadFailure extends GeolocationState {
  final Error error;

  const GeolocationLoadFailure({
    this.error,
  });
}
