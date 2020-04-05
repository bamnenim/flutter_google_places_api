import 'package:equatable/equatable.dart';
import 'package:google_places_api/models/query_prediction.dart';
import 'package:meta/meta.dart';
import 'package:google_places_api/core/utills/place_status.dart';
import 'package:google_places_api/responses/place_response.dart';

class QueryAutocompleteResponse extends PlaceResponse with EquatableMixin{
  final PlaceStatus status;
  final List<QueryPrediction> predictions;
  QueryAutocompleteResponse({
    @required this.status,
    this.predictions
  }) : super(status: status);

  factory QueryAutocompleteResponse.fromJson(Map json) =>
    json != null ? QueryAutocompleteResponse(
      status: PlaceStatus(
        status: json['status'],
        errorMessage: json['error_message'] != null ? json['error_message'] : null,
      ),
      predictions: json['predictions']
      ?.map((p)=>QueryPrediction.fromJson(p))
      ?.toList()
      ?.cast<QueryPrediction>()
    ) : null;

  Map<String, dynamic> toJson(){
    var map = Map<String, dynamic>();
    map["status"] = this.status.status;
    if(this.status.errorMessage != null) {
      map["error_message"] = this.status.errorMessage;
    }
    map["predircts"] = this.predictions;
    return map;
  }

  @override
  String toString() {
    return this.toJson().toString();
  }

  @override
  List<Object> get props => [status, predictions];
}