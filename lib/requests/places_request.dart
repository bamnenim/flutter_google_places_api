import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:flutter_google_places_api/responses/place_response.dart';

const String _googlePlacesBaseUrl = 'https://maps.googleapis.com/maps/api/place/';

abstract class PlacesRequest{
  final String _key;
  String get key => _key;

  final String _url;
  String get url => _url;

  final Client _httpClient;
  Client get httpClient => _httpClient;

  PlacesRequest({
    String key,
    String url,
    Client httpClient,
  }) : _url = '$_googlePlacesBaseUrl$url?',
      _key = key,
      _httpClient = httpClient ?? Client();

  String buildUrl();
  Future<PlaceResponse> call();
  Map<String, dynamic> getQueryParams();

  @protected
  String buildQuery(Map<String, dynamic> params) {
    final query = [];
    params.forEach((key, val) {
      if (val != null) {
        if (val is Iterable) {
          query.add("$key=${val.map((v) => v.toString()).join(",")}");
        } else {
          query.add('$key=${val.toString()}');
        }
      }
    });
    return query.join('&');
  }

  void dispose() => httpClient.close();

  @protected
  Future<Response> getHttpFrom(String url) => httpClient.get(url);

  @protected
  Future<Response> postHttpTo(String url, String body) {
    return httpClient.post(url, body: body, headers: {
      'Content-type': 'application/json',
    });
  }
}