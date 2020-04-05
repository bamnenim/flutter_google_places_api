import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_google_places_api/models/location.dart';
import 'package:flutter_google_places_api/requests/place_autocomplete_request.dart';
import 'package:flutter_google_places_api/responses/place_autocomplete_response.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client{}
class MockPlaceAutocompleteRequest extends Mock implements PlaceAutocompleteRequest{}

void main() {

  MockHttpClient mockHttpClient;
  MockPlaceAutocompleteRequest mockPlaceAutocompleteRequest;

  final tInput = 'test_input';
  final tKey = 'test_key';
  final tSucccessResponse = PlaceAutocompleteResponse.fromJson(json.decode(fixture('place_autocomplete_test_data.json')));
  final tFailureResponse = PlaceAutocompleteResponse.fromJson(json.decode(fixture('zero_results.json')));
  final tKeyFailureReponse = 
  PlaceAutocompleteResponse.fromJson(json.decode(fixture('invalid_api_key.json')));
  final tUrl = 
  'https://maps.googleapis.com/maps/api/place/autocomplete/json?key=test_key&input=test_input';
  final tQueryParams = {
    'key': tKey,
    'input': tInput,
    'session_token': null,
    'offset': null,
    'origin': null,
    'location': null,
    'radius': null,
    'language': 'kr',
    'types': null,
    'components': null,
    'strict_bounds': null,
  };
  final tQuery = 
  'key=test_key&input=test_input&location=37.76999,-122.44696&radius=500';

  setUp(() {
    mockHttpClient = MockHttpClient();
    mockPlaceAutocompleteRequest = MockPlaceAutocompleteRequest();
  });

  test('get query params should return map object matching each prams and value', 
  () {
    ///arrange
    when(mockPlaceAutocompleteRequest.getQueryParams()).thenAnswer((_)=>tQueryParams);
    ///act
    var mockQueryParams = mockPlaceAutocompleteRequest.getQueryParams();
    var gottonQueryParams = PlaceAutocompleteRequest(
      key: tKey, 
      input: tInput, 
      language: 'kr'
    ).getQueryParams();
    ///assert
    verify(mockPlaceAutocompleteRequest.getQueryParams());
    expect(mockQueryParams, gottonQueryParams);
  });

  test('build query test', 
  () {
    ///arrange
    when(mockPlaceAutocompleteRequest.buildQuery(any)).thenAnswer((_)=>tQuery);
    var tRequest = PlaceAutocompleteRequest(
      key: tKey,
      input: tInput,
      location: Location(lat: 37.76999, lng: -122.44696),
      radius: 500,
    );
    ///act
    var mockQuery = mockPlaceAutocompleteRequest.buildQuery({});
    var builtQuery = tRequest.buildQuery(tRequest.getQueryParams());
    ///assert
    verify(mockPlaceAutocompleteRequest.buildQuery({}));
    expect(mockQuery, builtQuery);
  });

  test(' build url test', 
  () async {
    ///arrange
    when(mockPlaceAutocompleteRequest.buildUrl())
    .thenAnswer((_) => tUrl);
    ///act
    var mockUrl = mockPlaceAutocompleteRequest.buildUrl();
    var builtUrl = PlaceAutocompleteRequest(key: tKey, input: tInput).buildUrl();
    ///assert
    verify(mockPlaceAutocompleteRequest.buildUrl());
    expect(mockUrl, builtUrl);
  });

  test('should return place autocomplete response when the call is successful',
  () async  {
    ///arrange
    when(mockHttpClient.get(any))
    .thenAnswer((_) async => http.Response(fixture('place_autocomplete_test_data.json'), 200));
    ///act
    var response = await PlaceAutocompleteRequest(
      key: tKey, 
      input: tInput, 
      httpClient: mockHttpClient
    ).call();
    ///assert
    verify(mockHttpClient.get(any));
    expect(tSucccessResponse.status.status, response.status.status);
    expect(tSucccessResponse.predictions, response.predictions);
  });

  test('should return place autocomplete response when the call is unsuccessful',
  () async  {
    ///arrange
    when(mockHttpClient.get(any))
    .thenAnswer((_) async => http.Response(fixture('zero_results.json'), 404));
    ///act
    var response = await PlaceAutocompleteRequest(
      key: tKey, 
      input: tInput, 
      httpClient: mockHttpClient
    ).call();
    ///assert
    verify(mockHttpClient.get(any));
    expect(tFailureResponse.status.status, response.status.status);
    expect(tFailureResponse.predictions, response.predictions);
  });

  test('should response have error message field when the call has error message',
  () async  {
    ///arrange
    when(mockHttpClient.get(any))
    .thenAnswer((_) async => http.Response(fixture('invalid_api_key.json'), 404));
    ///act
    var response = await PlaceAutocompleteRequest(
      key: tKey, 
      input: tInput, 
      httpClient: mockHttpClient
    ).call();
    ///assert
    verify(mockHttpClient.get(any));
    expect(tKeyFailureReponse.status.status, response.status.status);
    expect(tKeyFailureReponse.predictions, response.predictions);
  });
}