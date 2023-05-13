part of 'places_bloc.dart';

@immutable
abstract class PlacesEvent {}

class NearbyPlaceRequested extends PlacesEvent {
  NearbyPlaceRequested(this.position);

  // final NearbyPlace selectedPlace;
  final Position position;
}
