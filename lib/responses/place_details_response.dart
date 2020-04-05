import 'package:equatable/equatable.dart';
import 'package:flutter_google_places_api/core/utills/place_status.dart';
import 'package:flutter_google_places_api/models/place_details_result.dart';
import 'package:flutter_google_places_api/responses/place_response.dart';
import 'package:meta/meta.dart';

class PlaceDetailsResponse extends PlaceResponse with EquatableMixin{
  final PlaceStatus status;
  final List<String> htmlAttributions;
  final PlaceDetailsResult result;
  
  PlaceDetailsResponse({
    @required this.status,
    this.result,
    this.htmlAttributions
  }) : super(status: status);

  factory PlaceDetailsResponse.fromJson(Map json) => 
    json != null ? PlaceDetailsResponse(
      status: PlaceStatus(
        status: json['status'],
        errorMessage: json['error_message'] != null ? json["error_message"] : null,
      ),
      htmlAttributions: json['html_attributions'] != null ? 
        (json['html_attributions'] as List)?.cast<String>() : [],
      result: json['result'] != null ? PlaceDetailsResult.fromJson(json['result']) : null,
    ) : null ;

  Map<String, dynamic> toJson(){
    var map = Map<String, dynamic>();
    map["status"] = this.status.status;
    map["error_message"] ??= this.status.errorMessage;
    map["html_attributions"] = this.htmlAttributions;
    map["result"] = this.result;
    return map;
  }

  @override
  String toString() {
    return this.toJson().toString();
  }

  @override
  List<Object> get props => [status, htmlAttributions, result];
}