import 'dart:convert';

import 'package:flutter_google_places_api/models/location.dart';
import 'package:flutter_google_places_api/requests/places_request.dart';
import 'package:flutter_google_places_api/responses/text_search_response.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

class TextSearchRequest extends PlacesRequest{
  final String key;
  final String query;
  final String region;
  final Location location;
  final num radius;
  final String language;
  final int minPrice;
  final int maxPrice;
  final bool openNow;
  final String pageToken;
  final String type;
  Client httpClient;

  TextSearchRequest({
    @required this.key,
    @required this.query,
    this.region,
    this.location,
    this.radius,
    this.language,
    this.minPrice,
    this.maxPrice,
    this.openNow,
    this.pageToken,
    this.type,
    this.httpClient,
  }) : super(key: key, url: 'textsearch/json'){
    httpClient ??= Client();
  }

  @override
  String buildUrl() {
    var queryString = buildQuery(getQueryParams());
    return '$url$queryString';
  }

  @override
  Future<TextSearchResponse> call() async => 
    TextSearchResponse.fromJson(json.decode((await getHttpFrom(buildUrl())).body));

  @override
  Map<String, dynamic> getQueryParams() {
    var params = {
      'key': key,
      'query' : Uri.encodeQueryComponent(query),
      'region' : region,
      'location' : location,
      'radius' : radius,
      'language' : language,
      'minprice' : minPrice,
      'maxprice' : maxPrice,
      'opennow' : openNow,
      'pagetoken' : pageToken,
      'type' : type,
    };
    return params;
  }
  
}