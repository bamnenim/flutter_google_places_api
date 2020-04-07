import 'package:equatable/equatable.dart';
import 'package:flutter_google_places_api/models/geometry.dart';
import 'package:flutter_google_places_api/models/model.dart';
import 'package:flutter_google_places_api/models/opening_hours.dart';
import 'package:flutter_google_places_api/models/photo.dart';

class Candidate extends Model with EquatableMixin {
  final String formattedAddress;
  final Geometry geometry;
  final String name;
  final OpeningHours openingHours;
  final List<Photo> photos;
  final num rating;
  final String placeId;

  Candidate(
      {this.formattedAddress,
      this.geometry,
      this.name,
      this.openingHours,
      this.photos,
      this.rating,
      this.placeId});

  factory Candidate.fromJson(Map map) => map != null
      ? Candidate(
          formattedAddress: map['formatted_address'],
          geometry: Geometry.fromJson(map['geometry']),
          name: map['name'],
          openingHours: map['opening_hours'] != null
              ? OpeningHours.fromJson(map['opening_hours'])
              : null,
          photos: map['photos']
              ?.map((p) => Photo.fromJson(p))
              ?.toList()
              ?.cast<Photo>(),
          rating: map['rating'],
          placeId: map['place_id'],
        )
      : null;

  @override
  List<Object> get props =>
      [formattedAddress, name, openingHours, rating, placeId];

  @override
  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();
    if (formattedAddress != null) map['formatted_address'] = formattedAddress;
    if (geometry != null) map['geometry'] = geometry.toJson();
    if (name != null) map['name'] = name;
    if (openingHours != null) map['opening_hours'] = openingHours.toJson();
    if (photos != null)
      map['photos'] = photos?.map((p) => p.toJson())?.toList();
    if (rating != null) map['rating'] = rating;
    if (placeId != null) map['place_id'] = placeId;
    return map;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
