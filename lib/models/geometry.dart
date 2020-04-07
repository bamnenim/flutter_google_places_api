import 'package:equatable/equatable.dart';
import 'package:flutter_google_places_api/models/location.dart';
import 'package:flutter_google_places_api/models/viewport.dart';

class Geometry extends Equatable {
  final Location location;
  final Viewport viewport;

  Geometry({this.location, this.viewport});

  factory Geometry.fromJson(Map map) => map != null
      ? Geometry(
          location: Location.fromJson(map['location']),
          viewport: map['viewport'] != null
              ? Viewport.fromJson(map['viewport'])
              : null,
        )
      : null;

  Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "viewport": viewport.toJson(),
      };

  @override
  String toString() {
    return toJson().toString();
  }

  @override
  List<Object> get props => [location, viewport];
}
