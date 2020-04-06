import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_google_places_api/requests/query_autocomplete_request.dart';
import 'package:flutter_google_places_api/responses/query_autocomplete_response.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client{}
class MockQueryAutocompleteRequest extends Mock implements QueryAutocompleteRequest{}

void main() {

  MockHttpClient mockHttpClient;
  MockQueryAutocompleteRequest mockPlaceAutocompleteRequest;

  final tInput = 'test_input';
  final tKey = 'test_key';
  final tSucccessResponse = QueryAutocompleteResponse.fromJson(json.decode(fixture('query_autocomplete_test_data.json')));
  final tFailureResponse = QueryAutocompleteResponse.fromJson(json.decode(fixture('zero_results.json')));
  final tKeyFailureReponse = 
  QueryAutocompleteResponse.fromJson(json.decode(fixture('invalid_api_key.json')));
  final tUrl = 
  'https://maps.googleapis.com/maps/api/place/queryautocomplete/json?key=test_key&input=test_input';
  final tQueryParams = {
    'key': tKey,
    'input': tInput,
    'offset': null,
    'location': null,
    'radius': null,
    'language': 'kr',
  };

  setUp(() {
    mockHttpClient = MockHttpClient();
    mockPlaceAutocompleteRequest = MockQueryAutocompleteRequest();
  });

  group('query autocomplete request tests : ', 
  () {
    test('get query params should return map object matching each prams and value', 
    () {
      ///arrange
      when(mockPlaceAutocompleteRequest.getQueryParams()).thenAnswer((_)=>tQueryParams);
      ///act
      var mockQueryParams = mockPlaceAutocompleteRequest.getQueryParams();
      var gottonQueryParams = QueryAutocompleteRequest(
        key: tKey, 
        input: tInput, 
        language: 'kr'
      ).getQueryParams();
      ///assert
      verify(mockPlaceAutocompleteRequest.getQueryParams());
      expect(mockQueryParams, gottonQueryParams);
    });

    test(' build url test', 
    () async {
      ///arrange
      when(mockPlaceAutocompleteRequest.buildUrl())
      .thenAnswer((_) => tUrl);
      ///act
      var mockUrl = mockPlaceAutocompleteRequest.buildUrl();
      var builtUrl = QueryAutocompleteRequest(key: tKey, input: tInput).buildUrl();
      ///assert
      verify(mockPlaceAutocompleteRequest.buildUrl());
      expect(mockUrl, builtUrl);
    });

    test('should return place autocomplete response when the call is successful',
    () async  {
      ///arrange
      when(mockHttpClient.get(any))
      .thenAnswer((_) async => http.Response(fixture('query_autocomplete_test_data.json'), 200));
      ///act
      var response = await QueryAutocompleteRequest(
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
      var response = await QueryAutocompleteRequest(
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
      var response = await QueryAutocompleteRequest(
        key: tKey, 
        input: tInput, 
        httpClient: mockHttpClient
      ).call();
      ///assert
      verify(mockHttpClient.get(any));
      expect(tKeyFailureReponse.status.status, response.status.status);
      expect(tKeyFailureReponse.predictions, response.predictions);
    });
  });
}