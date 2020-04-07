import 'package:equatable/equatable.dart';
import 'package:flutter_google_places_api/models/place_prediction.dart';
import 'package:meta/meta.dart';
import 'package:flutter_google_places_api/core/utills/place_status.dart';
import 'package:flutter_google_places_api/responses/place_response.dart';

class PlaceAutocompleteResponse extends PlaceResponse with EquatableMixin {
  final PlaceStatus status;
  final List<PlacePrediction> predictions;
  PlaceAutocompleteResponse({@required this.status, this.predictions})
      : super(status: status);

  factory PlaceAutocompleteResponse.fromJson(Map json) => json != null
      ? PlaceAutocompleteResponse(
          status: PlaceStatus(
            status: json['status'],
            errorMessage:
                json['error_message'] != null ? json['error_message'] : null,
          ),
          predictions: json['predictions']
              ?.map((p) => PlacePrediction.fromJson(p))
              ?.toList()
              ?.cast<PlacePrediction>())
      : null;

  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();
    map["status"] = this.status.status;
    if (this.status.errorMessage != null) {
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
