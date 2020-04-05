import 'package:equatable/equatable.dart';
import 'package:flutter_google_places_api/models/geometry.dart';
import 'package:flutter_google_places_api/models/model.dart';
import 'package:flutter_google_places_api/models/opening_hours.dart';
import 'package:flutter_google_places_api/models/photo.dart';
import 'package:flutter_google_places_api/models/plus_code.dart';

class TextSearchResult extends Model with EquatableMixin {

  final String formattedAddress;
  final Geometry geometry;
  final String icon;
  final String id;
  final String name;
  final OpeningHours openingHours;
  final List<Photo> photos;
  final String placeId;
  final PlusCode plusCode;
  final num rating;
  final String reference;
  final List<String> types;
  final int userRatingsTotal;

  TextSearchResult({
    this.formattedAddress,
    this.geometry,
    this.icon,
    this.id,
    this.name,
    this.openingHours,
    this.photos,
    this.placeId,
    this.plusCode,
    this.rating,
    this.reference,
    this.types,
    this.userRatingsTotal
  });

  factory TextSearchResult.fromJson(Map map) => 
    map != null ? TextSearchResult(
      formattedAddress: map['formatted_address'],
      geometry: Geometry.fromJson(map['geometry']),
      icon: map['icon'],
      id: map['id'],
      name: map['name'],
      openingHours: map['opening_hours'] != null ? 
        OpeningHours.fromJson(map['opening_hours']) : null,
      photos: map['photos']
        ?.map((p)=>Photo.fromJson(p))
        ?.toList()
        ?.cast<Photo>(),
      placeId: map['place_id'],
      plusCode: PlusCode.fromJson(map['plus_code']),
      rating: map['rating'],
      reference: map['reference'],
      types: (map['types'] as List).cast<String>(),
      userRatingsTotal: map['user_ratings_total'],
    ) : null;

  @override
  List<Object> get props => [
    geometry, 
    icon, 
    id, 
    name, 
    openingHours, 
    placeId,
    plusCode
  ];

  @override
  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();
    map['formatted_address'] = formattedAddress;
    map['geometry'] = geometry.toJson();
    map['icon'] = icon;
    map['id'] = id;
    map['name'] = name;
    map['opening_hours'] = openingHours.toJson();
    map['photos'] = photos?.map((p)=>p.toJson())?.toList();
    map['place_id'] = placeId;
    map['plus_code'] = plusCode.toJson();
    map['rating'] = rating;
    map['reference'] = reference;
    map['types'] = types;
    map['user_ratings_total'] = userRatingsTotal;
    return map;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}