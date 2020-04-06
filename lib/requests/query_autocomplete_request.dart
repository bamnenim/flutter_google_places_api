import 'dart:convert';
import 'package:flutter_google_places_api/requests/places_request.dart';
import 'package:flutter_google_places_api/models/location.dart';
import 'package:flutter_google_places_api/responses/query_autocomplete_response.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

class QueryAutocompleteRequest extends PlacesRequest {

  final String key;
  final String input;
  final num offset;
  final Location location;
  final num radius;
  final String language;
  Client httpClient;

  QueryAutocompleteRequest({
    @required this.key,
    @required this.input,
    this.offset,
    this.location,
    this.radius,
    this.language,
    this.httpClient,
  }) : super(
    key: key, 
    url: 'queryautocomplete/json', 
    httpClient: httpClient
  ) {
    httpClient ??= Client();
  }

  @override
  String buildUrl() {
    var queryString = super.buildQuery(getQueryParams());
    return '$url$queryString';
  }

  @override
  Future<QueryAutocompleteResponse> call() async =>
    QueryAutocompleteResponse.fromJson(json.decode((await getHttpFrom(buildUrl())).body)); 

  @override
  Map<String, dynamic> getQueryParams() {
    var params = {
      'key': key,
      'input': Uri.encodeComponent(input),
      'offset': offset,
      'location': location,
      'radius': radius,
      'language': language,
    };
    return params;
  }

  @override
  String toString() {
    return getQueryParams().toString();
  }
}