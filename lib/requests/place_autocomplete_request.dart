import 'dart:convert';

import 'package:flutter_google_places_api/models/components.dart';
import 'package:flutter_google_places_api/requests/places_request.dart';
import 'package:flutter_google_places_api/models/location.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:flutter_google_places_api/responses/place_autocomplete_response.dart';

class PlaceAutocompleteRequest extends PlacesRequest {
  final String key;
  final String input;
  final String sessionToken;
  final num offset;
  final Location origin;
  final Location location;
  final num radius;
  final String language;
  final List<String> types;
  final Components components;
  final bool strictBounds;
  Client httpClient;

  PlaceAutocompleteRequest({
    @required this.key,
    @required this.input,
    this.sessionToken,
    this.offset,
    this.origin,
    this.location,
    this.radius,
    this.language,
    this.types,
    this.components,
    this.strictBounds,
    this.httpClient,
  }) : super(key: key, url: 'autocomplete/json', httpClient: httpClient) {
    httpClient ??= Client();
  }

  @override
  String buildUrl() {
    var queryString = super.buildQuery(getQueryParams());
    return '$url$queryString';
  }

  @override
  Future<PlaceAutocompleteResponse> call() async =>
      PlaceAutocompleteResponse.fromJson(
          json.decode((await getHttpFrom(buildUrl())).body));

  @override
  Map<String, dynamic> getQueryParams() {
    var params = {
      'key': key,
      'input': Uri.encodeComponent(input),
      'session_token': sessionToken,
      'offset': offset,
      'origin': origin,
      'location': location,
      'radius': radius,
      'language': language,
      'types': types,
      'components': components,
      'strict_bounds': strictBounds,
    };
    return params;
  }

  @override
  String toString() {
    return getQueryParams().toString();
  }
}
