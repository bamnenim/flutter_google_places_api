import 'dart:convert';

import 'package:google_places_api/requests/places_request.dart';
import 'package:google_places_api/responses/find_place_response.dart';
import 'package:google_places_api/responses/place_response.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

class FindPlaceRequest extends PlacesRequest{
  final String key;
  final String input;
  final String inputType;
  final String language;
  final List<String> fields;
  final String locationBias; // need to be fixed
  Client httpClient;

  FindPlaceRequest({
    @required this.key,
    @required this.input,
    @required this.inputType,
    this.language,
    this.fields,
    this.locationBias,
    this.httpClient
  }) : super(
    key: key,
    url: 'findplacefromtext/json',
    httpClient : httpClient,
  ){
    httpClient ??= Client();
  }


  @override
  String buildUrl() {
    var queryString = super.buildQuery(getQueryParams());
    return '$url$queryString';
  }

  @override
  Future<FindPlaceResponse> call() async => 
    FindPlaceResponse.fromJson(json.decode((await getHttpFrom(buildUrl())).body));

  @override
  Map<String, dynamic> getQueryParams() {
    var params = {
      'input': input,
      'inputtype': inputType,
      'language': language,
      'fields': fields,
      'locationbias': locationBias,
      'key': key,
    };
    return params;
  }
  
}