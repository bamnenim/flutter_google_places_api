import 'package:equatable/equatable.dart';
import 'package:flutter_google_places_api/models/matched_substrings.dart';
import 'package:flutter_google_places_api/models/structured_formatting.dart';
import 'package:flutter_google_places_api/models/term.dart';

class QueryPrediction extends Equatable{
  final String description;
  final List<MatchedSubstring> matchedSubstrings;
  final StructuredFormatting structuredFormatting;
  final List<Term> terms;
  final String placeId; //only if the prediction is place
  final List<String> types; //only if the prediction is place
  
  QueryPrediction({
    this.description,
    this.matchedSubstrings,
    this.structuredFormatting,
    this.terms,
    this.placeId,
    this.types,
  });

  factory QueryPrediction.fromJson(Map map) => 
    map != null ? QueryPrediction(
      description: map['description'],
      matchedSubstrings: map['matched_substrings']
      ?.map((p)=>MatchedSubstring.fromJson(p))
      ?.toList()
      ?.cast<MatchedSubstring>(),
      structuredFormatting: map['structured_formatting'] != null ? 
        StructuredFormatting.fromJson(map['structured_formatting']) : null,
      terms: map['terms']
      ?.map((p)=>Term.fromJson(p))
      ?.toList()
      ?.cast<Term>(),
      placeId: map['place_id'],
      types: map['types'] != null ? (map['type'] as List)?.cast<String>() : null,
    ): null;

  Map<String, dynamic> toJson(){
    var map = Map<String, dynamic>();
    map['description'] = description;
    map['matched_substrings'] = matchedSubstrings?.map((p)=>p.toJson())?.toList();
    if(structuredFormatting != null)
      map['structured_formatting'] = structuredFormatting.toJson();
    map['terms'] = terms?.map((p)=>p.toJson())?.toList();
    if(placeId != null)
      map['place_id'] = placeId;
    if(types != null)
      map['types'] = types;
    return map;
  }

  @override
  String toString() {
    return this.toJson().toString();
  }

  @override
  List<Object> get props => [description, matchedSubstrings, terms];
}