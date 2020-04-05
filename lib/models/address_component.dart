import 'package:equatable/equatable.dart';
import 'package:flutter_google_places_api/models/model.dart';

class AddressComponent extends Model with EquatableMixin{
  final String longName;
  final String shortName;
  final List<String> types;

  AddressComponent({
    this.longName,
    this.shortName,
    this.types,
  });

  factory AddressComponent.fromJson(Map map) =>
    map != null ? AddressComponent(
      longName: map['long_name'],
      shortName: map['short_name'],
      types: (map['types'] as List)?.cast<String>(),
    ) : null;

  @override
  List<Object> get props => [longName, shortName, types];

  @override
  Map<String, dynamic> toJson() => {
    "long_name": longName,
    "short_name": shortName,
    "types": types,
  };

  @override
  String toString() {
    return toJson().toString();
  }
}