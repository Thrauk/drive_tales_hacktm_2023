class VisitedPlace {
  final String placeId;
  final String placeName;

  VisitedPlace({
    required this.placeId,
    required this.placeName,
  });

  factory VisitedPlace.fromMap(Map<String, dynamic> json) => VisitedPlace(
        placeId: json["place_id"],
        placeName: json["place_name"],
      );

  Map<String, dynamic> toMap() => {
        "place_id": placeId,
        "place_name": placeName,
      };

  static List<VisitedPlace> fromList(List<dynamic> list) {
    final places = <VisitedPlace>[];
    for (final dynamic element in list) {
      places.add(VisitedPlace.fromMap(element as Map<String, dynamic>));
    }
    return places;
  }
}
