import 'package:equatable/equatable.dart';
import 'package:flutter_google_places_api/models/matched_substrings.dart';
import 'package:flutter_google_places_api/models/structured_formatting.dart';
import 'package:flutter_google_places_api/models/term.dart';

class PlacePrediction extends Equatable {
  final String description;
  final String id;
  final List<MatchedSubstring> matchedSubstrings;
  final String placeId;
  final String reference;
  final StructuredFormatting structuredFormatting;
  final List<Term> terms;
  final List<String> types;
  final num distanceMeters;

  PlacePrediction(
      {this.description,
      this.id,
      this.matchedSubstrings,
      this.placeId,
      this.reference,
      this.structuredFormatting,
      this.terms,
      this.types,
      this.distanceMeters});

  factory PlacePrediction.fromJson(Map map) => map != null
      ? PlacePrediction(
          description: map['description'],
          id: map['id'],
          matchedSubstrings: map['matched_substrings']
              ?.map((p) => MatchedSubstring.fromJson(p))
              ?.toList()
              ?.cast<MatchedSubstring>(),
          placeId: map['place_id'],
          reference: map['reference'],
          structuredFormatting: map['structured_formatting'] != null
              ? StructuredFormatting.fromJson(map['structured_formatting'])
              : null,
          terms: map['terms']
              ?.map((p) => Term.fromJson(p))
              ?.toList()
              ?.cast<Term>(),
          types: map['types'] != null
              ? (map['types'] as List)?.cast<String>()
              : null,
          distanceMeters: map['distance_meters'],
        )
      : null;

  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();
    map['description'] = description;
    map['id'] = id;
    map['matched_substrings'] =
        matchedSubstrings?.map((p) => p.toJson())?.toList();
    map['place_id'] = placeId;
    map['reference'] = reference;
    map['structured_formatting'] = structuredFormatting.toJson();
    map['terms'] = terms?.map((p) => p.toJson())?.toList();
    map['types'] = types;
    if (distanceMeters != null) map['distance_meters'] = distanceMeters;
    return map;
  }

  @override
  String toString() {
    return toJson().toString();
  }

  @override
  List<Object> get props => [
        description,
        id,
        matchedSubstrings,
        placeId,
        reference,
        structuredFormatting,
        terms,
        types,
        distanceMeters
      ];
}
