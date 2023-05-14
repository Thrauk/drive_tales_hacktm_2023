part of 'places_bloc.dart';

class PlacesState extends Equatable {
  const PlacesState({
    required this.currentPlace,
    required this.isEventLoading,
  });

  final NearbyPlace? currentPlace;
  final bool isEventLoading;

  factory PlacesState.initial() {
    return const PlacesState(
      currentPlace: null,
      isEventLoading: false,
    );
  }

  PlacesState copyWith({
    Nullable<NearbyPlace>? currentPlace,
    bool? isEventLoading,
  }) {
    return PlacesState(
      currentPlace: currentPlace != null ? currentPlace.value : this.currentPlace,
      isEventLoading: isEventLoading ?? this.isEventLoading,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        currentPlace,
        isEventLoading,
      ];
}
