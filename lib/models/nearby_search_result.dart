import 'package:equatable/equatable.dart';
import 'package:flutter_google_places_api/models/geometry.dart';
import 'package:flutter_google_places_api/models/model.dart';
import 'package:flutter_google_places_api/models/photo.dart';

class NearbySearchResult extends Model with EquatableMixin {
  final Geometry geometry;
  final String icon;
  final String id;
  final String name;
  final List<Photo> photos;
  final String placeId;
  final String reference;
  final String scope;
  final List<String> types;
  final String vicinity;

  NearbySearchResult({
    this.geometry,
    this.icon,
    this.id,
    this.name,
    this.photos,
    this.placeId,
    this.reference,
    this.scope,
    this.types,
    this.vicinity,
  });

  factory NearbySearchResult.fromJson(Map map) => map != null
      ? NearbySearchResult(
          geometry: map['geometry'] != null
              ? Geometry.fromJson(map['geometry'])
              : null,
          icon: map['icon'],
          id: map['id'],
          name: map['name'],
          photos: map['photos']
              ?.map((p) => Photo.fromJson(p))
              ?.toList()
              ?.cast<Photo>(),
          placeId: map['place_id'],
          reference: map['reference'],
          scope: map['scope'],
          types: (map['types'] as List)?.cast<String>(),
          vicinity: map['vicinity'],
        )
      : null;

  @override
  List<Object> get props =>
      [geometry, icon, id, name, placeId, reference, scope, vicinity];

  @override
  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();
    map['geometry'] = geometry.toJson();
    map['icon'] = icon;
    map['id'] = id;
    map['name'] = name;
    map['photos'] = photos?.map((p) => p.toJson())?.toList();
    map['place_id'] = placeId;
    map['reference'] = reference;
    map['scope'] = scope;
    map['types'] = types;
    if (vicinity != null) map['vicinity'] = vicinity;
    return map;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
