import 'dart:convert';

import 'package:flutter_google_places_api/requests/places_request.dart';
import 'package:flutter_google_places_api/responses/place_details_response.dart';
import 'package:flutter_google_places_api/responses/place_response.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart';

class PlaceDetailsRequest extends PlacesRequest {
  final String key;
  final String placeId;
  final String language;
  final String region;
  final String sessionToken;
  final List<String> fields;
  Client httpClient;

  PlaceDetailsRequest({
    @required this.key,
    @required this.placeId,
    this.language,
    this.region,
    this.sessionToken,
    this.fields,
    this.httpClient,
  }) : super(key: key, url: 'details/json', httpClient: httpClient) {
    httpClient ??= Client();
  }

  @override
  String buildUrl() {
    var queryString = super.buildQuery(getQueryParams());
    return '$url$queryString';
  }

  @override
  Future<PlaceDetailsResponse> call() async => PlaceDetailsResponse.fromJson(
      json.decode((await getHttpFrom(buildUrl())).body));

  @override
  Map<String, dynamic> getQueryParams() {
    var params = {
      'key': key,
      'place_id': placeId,
      'language': language,
      'region': region,
      'session_token': sessionToken,
      'fields': fields,
    };
    return params;
  }
}
