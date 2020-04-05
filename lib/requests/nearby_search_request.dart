import 'dart:convert';

import 'package:flutter_google_places_api/models/location.dart';
import 'package:flutter_google_places_api/requests/places_request.dart';
import 'package:flutter_google_places_api/responses/nearby_search_response.dart';
import 'package:flutter_google_places_api/responses/place_response.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

class NearbySearchRequest extends PlacesRequest{
  final String key;
  final Location location;
  final num radius;
  Client httpClient;
  final int minPrice;
  final int maxPrince;
  final String keyword;
  final String language;
  final String name;
  final bool openNow;
  final String rankBy;
  final String type;
  final String pageToken;

  NearbySearchRequest({
    @required this.key,
    @required this.location,
    @required this.radius,
    this.httpClient,
    this.minPrice,
    this.maxPrince,
    this.keyword,
    this.language,
    this.name,
    this.openNow,
    this.rankBy,
    this.type,
    this.pageToken,
  }) : super(key: key, url: 'nearbysearch/json'){
    httpClient ??= Client();
  }
  @override
  String buildUrl() {
    var queryString = buildQuery(getQueryParams());
    return '$url$queryString';
  }

  @override
  Future<NearbySearchResponse> call() async => 
    NearbySearchResponse.fromJson(json.decode((await getHttpFrom(buildUrl())).body));

  @override
  Map<String, dynamic> getQueryParams() {
    var params = {
      'key' : key,
      'location' : location,
      'radius' : radius,
      'minprice' : minPrice,
      'maxprice' : maxPrince,
      'keyword' : keyword,
      'language' : language,
      'name' : name,
      'opennow' : openNow,
      'rankby' : rankBy,
      'type' : type,
      'pagetoken' : pageToken,
    };
    return params;
  }
  
}