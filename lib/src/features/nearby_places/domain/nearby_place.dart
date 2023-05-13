class NearbyPlace {
  String businessStatus;
  Geometry geometry;
  String icon;
  String iconBackgroundColor;
  String iconMaskBaseUri;
  String name;
  List<Photo>? photos;
  String placeId;
  String reference;
  String scope;
  List<String> types;
  String vicinity;
  bool permanentlyClosed;

  NearbyPlace({
    required this.businessStatus,
    required this.geometry,
    required this.icon,
    required this.iconBackgroundColor,
    required this.iconMaskBaseUri,
    required this.name,
    required this.photos,
    required this.placeId,
    required this.reference,
    required this.scope,
    required this.types,
    required this.vicinity,
    this.permanentlyClosed = false,
  });

  factory NearbyPlace.fromMap(Map<String, dynamic> json) => NearbyPlace(
        businessStatus: json["business_status"],
        geometry: Geometry.fromMap(json["geometry"]),
        icon: json["icon"],
        iconBackgroundColor: json["icon_background_color"],
        iconMaskBaseUri: json["icon_mask_base_uri"],
        name: json["name"],
        photos: json["photos"] == null ? [] : List<Photo>.from(json["photos"]!.map((x) => Photo.fromMap(x))),
        placeId: json["place_id"],
        reference: json["reference"],
        scope: json["scope"],
        types: List<String>.from(json["types"].map((x) => x)),
        vicinity: json["vicinity"],
        permanentlyClosed: json['permanently_closed'] ?? false,
      );

  Map<String, dynamic> toMap() => {
        "business_status": businessStatus,
        "geometry": geometry.toMap(),
        "icon": icon,
        "icon_background_color": iconBackgroundColor,
        "icon_mask_base_uri": iconMaskBaseUri,
        "name": name,
        "photos": photos == null ? [] : List<dynamic>.from(photos!.map((x) => x.toMap())),
        "place_id": placeId,
        "reference": reference,
        "scope": scope,
        "types": List<dynamic>.from(types.map((x) => x)),
        "vicinity": vicinity,
      };

  static List<NearbyPlace> fromList(List<dynamic> list) {
    final places = <NearbyPlace>[];
    for (final dynamic element in list) {
      places.add(NearbyPlace.fromMap(element as Map<String, dynamic>));
    }
    return places;
  }
}

class Geometry {
  Location location;
  Viewport viewport;

  Geometry({
    required this.location,
    required this.viewport,
  });

  factory Geometry.fromMap(Map<String, dynamic> json) => Geometry(
        location: Location.fromMap(json["location"]),
        viewport: Viewport.fromMap(json["viewport"]),
      );

  Map<String, dynamic> toMap() => {
        "location": location.toMap(),
        "viewport": viewport.toMap(),
      };
}

class Location {
  double lat;
  double lng;

  Location({
    required this.lat,
    required this.lng,
  });

  factory Location.fromMap(Map<String, dynamic> json) => Location(
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "lat": lat,
        "lng": lng,
      };
}

class Viewport {
  Location northeast;
  Location southwest;

  Viewport({
    required this.northeast,
    required this.southwest,
  });

  factory Viewport.fromMap(Map<String, dynamic> json) => Viewport(
        northeast: Location.fromMap(json["northeast"]),
        southwest: Location.fromMap(json["southwest"]),
      );

  Map<String, dynamic> toMap() => {
        "northeast": northeast.toMap(),
        "southwest": southwest.toMap(),
      };
}

class Photo {
  int height;
  List<String> htmlAttributions;
  String photoReference;
  int width;

  Photo({
    required this.height,
    required this.htmlAttributions,
    required this.photoReference,
    required this.width,
  });

  factory Photo.fromMap(Map<String, dynamic> json) => Photo(
        height: json["height"],
        htmlAttributions: List<String>.from(json["html_attributions"].map((x) => x)),
        photoReference: json["photo_reference"],
        width: json["width"],
      );

  Map<String, dynamic> toMap() => {
        "height": height,
        "html_attributions": List<dynamic>.from(htmlAttributions.map((x) => x)),
        "photo_reference": photoReference,
        "width": width,
      };
}

class PlusCode {
  String compoundCode;
  String globalCode;

  PlusCode({
    required this.compoundCode,
    required this.globalCode,
  });

  factory PlusCode.fromMap(Map<String, dynamic> json) => PlusCode(
        compoundCode: json["compound_code"],
        globalCode: json["global_code"],
      );

  Map<String, dynamic> toMap() => {
        "compound_code": compoundCode,
        "global_code": globalCode,
      };
}
