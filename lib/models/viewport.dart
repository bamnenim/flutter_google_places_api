import 'package:equatable/equatable.dart';
import 'package:google_places_api/models/location.dart';

class Viewport extends Equatable {
  final Location northeast;
  final Location southwest;
  Viewport(this.northeast, this.southwest);

  factory Viewport.fromJson(Map map) =>
    map != null ? Viewport(
      Location.fromJson(map['northeast']),
      Location.fromJson(map['southwest']),
    ) : null;

  Map<String, dynamic> toJson() => {
    "northeast" : northeast.toJson(),
    "southwest" : southwest.toJson(),
  };

  @override
  String toString() {
    return toJson().toString();
  }

  @override
  List<Object> get props => [northeast, southwest];
}