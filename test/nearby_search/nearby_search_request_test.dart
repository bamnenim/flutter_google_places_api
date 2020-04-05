import 'dart:convert';

import 'package:flutter_google_places_api/models/location.dart';
import 'package:flutter_google_places_api/requests/nearby_search_request.dart';
import 'package:flutter_google_places_api/responses/nearby_search_response.dart';
import 'package:http/http.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements Client{}

void main() {
  MockHttpClient mockHttpClient;
  final tUrl = 
  'https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=test_key&location=-1.0,1.0&radius=200&keyword=cruise&type=restaurant';
  final tKey = 'test_key';
  final tLoaction = Location(lat: -1, lng: 1);
  final tRadius = 200;
  final utf8Header = {
    "content-type":"application/json; charset=utf-8"
  }; // for mcoking utf-8 charset http response
  
  setUp(() {
    mockHttpClient = MockHttpClient();
  });

  group('nearby search tests: ', () {
    test('build url', 
    () {
      ///arrange
      var url = NearbySearchRequest(
        key: tKey,
        location: tLoaction,
        radius: tRadius,
        httpClient: mockHttpClient,
        type: 'restaurant',
        keyword: 'cruise',
      ).buildUrl();
      ///act
      ///assert
      expect(tUrl, url);
    });

    test('call', 
    () async {
      ///arrange
      when(mockHttpClient.get(any))
      .thenAnswer((_) async => Response(
        fixture('nearby_search_test_data.json'),
        200,
        headers: utf8Header
      ));
      ///act
      var response = await NearbySearchRequest(
        key: tKey,
        location: tLoaction,
        radius: tRadius,
        httpClient: mockHttpClient,
      ).call();
      var tResponse = 
      NearbySearchResponse.fromJson(json.decode(fixture('nearby_search_test_data.json')));
      ///assert
      verify(mockHttpClient.get(any));
      expect(response, tResponse);
    });
  });
}