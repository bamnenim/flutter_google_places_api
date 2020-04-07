import 'package:equatable/equatable.dart';
import 'package:flutter_google_places_api/core/utills/place_status.dart';
import 'package:flutter_google_places_api/models/candidate.dart';
import 'package:flutter_google_places_api/models/debug_log.dart';
import 'package:flutter_google_places_api/responses/place_response.dart';
import 'package:meta/meta.dart';

class FindPlaceResponse extends PlaceResponse with EquatableMixin {
  final PlaceStatus status;
  final List<Candidate> candidates;
  final DebugLog debugLog;

  FindPlaceResponse({@required this.status, this.candidates, this.debugLog})
      : super(status: status);

  factory FindPlaceResponse.fromJson(Map json) => json != null
      ? FindPlaceResponse(
          status: PlaceStatus(
            status: json['status'],
            errorMessage:
                json['error_message'] != null ? json['error_message'] : null,
          ),
          candidates: json['candidates']
              ?.map((p) => Candidate.fromJson(p))
              ?.toList()
              ?.cast<Candidate>(),
          debugLog: DebugLog.fromJson(json['debug_log']),
        )
      : null;

  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();
    map["status"] = this.status.status;
    if (this.status.errorMessage != null) {
      map["error_message"] = this.status.errorMessage;
    }
    map["candidates"] = candidates?.map((p) => p.toJson())?.toList();
    if (debugLog != null) map['debug_log'] = debugLog.toJson();
    return map;
  }

  @override
  String toString() {
    return toJson().toString();
  }

  @override
  List<Object> get props => [status, candidates];
}
