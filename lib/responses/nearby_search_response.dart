import 'package:equatable/equatable.dart';
import 'package:google_places_api/core/utills/place_status.dart';
import 'package:google_places_api/models/nearby_search_result.dart';
import 'package:google_places_api/responses/place_response.dart';
import 'package:meta/meta.dart';

class NearbySearchResponse extends PlaceResponse with EquatableMixin{
  final PlaceStatus status;
  final List<NearbySearchResult> results;
  final List<String> htmlAttributions;

  NearbySearchResponse({
    @required this.status,
    this.results,
    this.htmlAttributions
  }) : super(status: status);

  factory NearbySearchResponse.fromJson(Map json) => 
    json != null ? NearbySearchResponse(
      status: PlaceStatus(
        status: json['status'],
        errorMessage: json['error_message'] != null ? json['error_message'] : null,
      ),
      htmlAttributions: json['html_attributions'] != null? 
        (json['html_attributions'] as List)?.cast<String>() : [],
      results: json['results']
      ?.map((p) => NearbySearchResult.fromJson(p))
      ?.toList()
      ?.cast<NearbySearchResult>()
    ) : null;

  Map<String, dynamic> toJson(){
    var map = Map<String, dynamic>();
    map['status'] = this.status.status;
    if(this.status.errorMessage != null) {
      map["error_message"] = this.status.errorMessage;
    }
    map['html_attributions'] = this.htmlAttributions;
    map['results'] = results?.map((p)=>p.toJson())?.toList();
    return map;
  }

  @override
  String toString() {
    return this.toJson().toString();
  }

  @override
  List<Object> get props => null;

}