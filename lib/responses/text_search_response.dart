import 'package:equatable/equatable.dart';
import 'package:flutter_google_places_api/core/utills/place_status.dart';
import 'package:flutter_google_places_api/models/text_search_result.dart';
import 'package:flutter_google_places_api/responses/place_response.dart';
import 'package:meta/meta.dart';

class TextSearchResponse extends PlaceResponse with EquatableMixin{
  final PlaceStatus status;
  final List<String> htmlAttributions;
  final List<TextSearchResult> results;

  TextSearchResponse({
    @required this.status,
    this.htmlAttributions,
    this.results,
  }) : super(status: status);

  factory TextSearchResponse.fromJson(Map json) => 
    json != null ? TextSearchResponse(
      status: PlaceStatus(
        status: json['status'],
        errorMessage: json['error_message'] != null ? json['error_message'] : null
      ),
      htmlAttributions: json['html_attributions'] != null ? 
        (json['html_attributions'] as List)?.cast<String>() : [],
      results: json['results']
      ?.map((p)=>TextSearchResult.fromJson(p))
      ?.toList()
      ?.cast<TextSearchResult>(),
    ) : null;

  Map<String, dynamic> toJson(){
    var map = Map<String, dynamic>();
    map['status'] = this.status.status;
    if(this.status.errorMessage != null){
      map['error_message'] = this.status.errorMessage;
    }
    map['html_attributions'] = this.htmlAttributions;
    map['results'] = results?.map((p)=>p.toJson())?.toList();
    return map;
  }

  @override
  String toString() {
    return toJson().toString();
  }

  @override
  List<Object> get props => [status, htmlAttributions, results];

}