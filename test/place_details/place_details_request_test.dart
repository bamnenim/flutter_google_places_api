import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_google_places_api/requests/place_autocomplete_request.dart';
import 'package:flutter_google_places_api/requests/place_details_request.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client{}
class MockPlaceDetailsRequest extends Mock implements PlaceDetailsRequest{}

void main(){

  MockHttpClient mockHttpClient;
  MockPlaceDetailsRequest mockPlaceDetailsRequest;

  final tPlaceId = 'test_place_id';
  final tKey = 'test_key';
  final tSessionToken = 'test_session_token';
  final tUrl = 
  'https://maps.googleapis.com/maps/api/place/details/json?key=test_key&place_id=test_place_id&session_token=test_session_token';
  final tQueryParams = {
    'key': tKey,
    'place_id': tPlaceId,
    'language': null,
    'region': null,
    'session_token': null,
    'fields': null,
  };
  final tQuery = 'key=test_key&place_id=test_place_id&fields=name,rating,formatted_phone_number';
  final utf8Header = {
    "content-type":"application/json; charset=utf-8"
  }; // for mcoking utf-8 charset http response

  setUp(() {
    mockHttpClient = MockHttpClient();
    mockPlaceDetailsRequest = MockPlaceDetailsRequest();
  });
  group('place details request test : ', 
  () {
    test('get query params should return map object matching each params and value', 
    () {
      ///arrange
      when(mockPlaceDetailsRequest.getQueryParams()).thenAnswer((_)=>tQueryParams);
      ///act
      var mockQueryParams = mockPlaceDetailsRequest.getQueryParams();
      var gottonQueryParams = PlaceDetailsRequest(
        key: tKey,
        placeId: tPlaceId
      ).getQueryParams();
      ///assert
      verify(mockPlaceDetailsRequest.getQueryParams());
      expect(mockQueryParams, gottonQueryParams);
    });

    test('build query test',
    () {
      ///arrange
      when(mockPlaceDetailsRequest.buildQuery(any)).thenAnswer((_)=>tQuery);
      var tRequest = PlaceDetailsRequest(
        key: tKey, 
        placeId: tPlaceId,
        fields: ['name', 'rating', 'formatted_phone_number'],
      );
      ///act
      var mockQuery = mockPlaceDetailsRequest.buildQuery({});
      var builtQuery = tRequest.buildQuery(tRequest.getQueryParams());
      ///assert
      verify(mockPlaceDetailsRequest.buildQuery({}));
      expect(mockQuery, builtQuery);
    });

    test('build url test', 
    () {
      ///arrange
      when(mockPlaceDetailsRequest.buildUrl()).thenAnswer((_)=>tUrl);
      ///act
      var mockUrl = mockPlaceDetailsRequest.buildUrl();
      var builtUrl = PlaceDetailsRequest(
        key: tKey, 
        placeId: tPlaceId, 
        sessionToken: tSessionToken
      ).buildUrl();
      ///assert
      verify(mockPlaceDetailsRequest.buildUrl());
      expect(mockUrl, builtUrl);
    });

    test('should return place details response when the call is successful', 
    () async {
      ///arrange
      when(mockHttpClient.get(any))
      .thenAnswer((_) async => 
        http.Response(fixture('place_details_test_data.json'), 200, headers: utf8Header));
      ///act
      var response = await PlaceDetailsRequest(
        key: tKey,
        placeId: tPlaceId,
        httpClient: mockHttpClient,
      ).call();
      ///assert
      verify(mockHttpClient.get(any));
    });

    test('should return place details response when the call has zero result', 
    () async {
      ///arrange
      when(mockHttpClient.get(any))
      .thenAnswer((_) async => 
        http.Response(fixture('zero_results.json'), 404, headers: utf8Header));
      ///act
      var response = await PlaceDetailsRequest(
        key: tKey,
        placeId: tPlaceId,
        httpClient: mockHttpClient,
      ).call();
      ///assert
      verify(mockHttpClient.get(any));
      expect(response.status.status, "ZERO_RESULTS");
      expect(response.status.errorMessage, null);
    });

    test('should return place details response when the call is invalid', 
    () async {
      ///arrange
      when(mockHttpClient.get(any))
      .thenAnswer((_) async => 
        http.Response(fixture('invalid_api_key.json'), 404, headers: utf8Header));
      ///act
      var response = await PlaceDetailsRequest(
        key: tKey,
        placeId: tPlaceId,
        httpClient: mockHttpClient,
      ).call();
      ///assert
      verify(mockHttpClient.get(any));
      expect(response.status.status, "REQUEST_DENIED");
      expect(response.status.errorMessage, "The provided API key is invalid.");
    });
  });
}
