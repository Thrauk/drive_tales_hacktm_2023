import 'package:bloc/bloc.dart';
import 'package:drive_tales/src/features/nearby_places/domain/nearby_place.dart';
import 'package:drive_tales/src/utils/nullable_field.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

part 'places_event.dart';
part 'places_state.dart';

class PlacesBloc extends Bloc<PlacesEvent, PlacesState> {
  PlacesBloc() : super(PlacesState.initial()) {
    on<PlacesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  Future<void> _onNearbyPlaceRequested(NearbyPlaceRequested event, Emitter<PlacesState> emit) async {
    emit(state.copyWith(
      isEventLoading: true,
    ));
  }
}
