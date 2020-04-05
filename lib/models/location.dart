import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Location extends Equatable{
  final double lat;
  final double lng;
  Location({
    @required this.lat,
    @required this.lng,
  });

  factory Location.fromJson(Map json) =>
    json != null ? Location(lat: json['lat'], lng: json['lng']) : null;

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };

  @override
  String toString() {
    return '$lat,$lng';
  }

  @override
  List<Object> get props => [lat, lng];
}