import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class PlaceStatus extends Equatable {
  static const okay = 'OK';
  static const zeroResults = 'ZERO_RESULTS';
  static const overQueryLimit = 'OVER_QUERY_LIMIT';
  static const requestDenied = 'REQUEST_DENIED';
  static const invalidRequest = 'INVALID_REQUEST';
  static const unknownErrorStatus = 'UNKNOWN_ERROR';
  static const notFound = 'NOT_FOUND';
  static const maxWaypointsExceeded = 'MAX_WAYPOINTS_EXCEEDED';
  static const maxRouteLengthExceeded = 'MAX_ROUTE_LENGTH_EXCEEDED';

  final String status;
  final String errorMessage;
  PlaceStatus({@required this.status, this.errorMessage});

  @override
  List<Object> get props => [status, errorMessage];
}

enum Status {
  okay,
  zero_result,
  over_query_limit,
  request_denied,
  invalid_request,
  unkown_error,
  max_way_point_exceeded,
  max_route_length_exceeded
}
