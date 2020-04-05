import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:google_places_api/core/utills/place_status.dart';
import 'package:google_places_api/models/query_prediction.dart';
import 'package:google_places_api/requests/query_autocomplete_request.dart';
import 'package:google_places_api/responses/query_autocomplete_response.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart';
import '../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements Client{}

void main() {
  MockHttpClient mockHttpClient;
  final utf8Header = {
    "content-type":"application/json; charset=utf-8"
  }; // for mcoking utf-8 charset http response
  final tKey = 'test_key';
  final tInput = 'test_input';
  
  setUp(() {
    mockHttpClient = MockHttpClient();
  });

  group('test creating place auto complete response',
  () {
    test('should return response obj when it is made from json response', 
    () {
      ///arrange
      var jsonMap = json.decode(fixture('query_autocomplete_test_data.json'));
      var tResponseFromJson = QueryAutocompleteResponse.fromJson(jsonMap);
      ///act
      var tResponseFromObject = QueryAutocompleteResponse(
        status: PlaceStatus(status: 'OK'),
        predictions: [
          QueryPrediction.fromJson(jsonMap["predictions"][0]),
          QueryPrediction.fromJson(jsonMap["predictions"][1]),
        ]
      );
      ///assert
      expect(tResponseFromJson, tResponseFromObject);
    });

    test('should return error response when it is made from json error response',
    () {
      ///arrange
      var jsonMap = fixture('zero_results.json');
      var tResponseFromJson = QueryAutocompleteResponse.fromJson(json.decode(jsonMap));
      ///act
      var tResponseFromObject = QueryAutocompleteResponse(
        status: PlaceStatus(status: 'ZERO_RESULTS', errorMessage: null),
        predictions: [],
      );
      ///assert
      expect(tResponseFromJson, tResponseFromObject);
    });
  });

  group('test with request', 
  () {
    test('should return place autocomplete response with full result when the call is successful', 
    () async {
      ///arrange
      when(mockHttpClient.get(any))
      .thenAnswer((_) async => Response(fixture('query_autocomplete_test_data.json'), 200, headers: utf8Header));
      ///act
      var response = await QueryAutocompleteRequest(
        key: tKey, 
        input: tInput, 
        httpClient: mockHttpClient
      ).call();
      ///assert
      verify(mockHttpClient.get(any));
      expect(response.status.status, 'OK');
    });

    test('should return error status when the call is unsuccessful', 
    () async {
      ///arrange
      when(mockHttpClient.get(any))
      .thenAnswer((_) async => Response(fixture('zero_results.json'), 404));
      ///act
      var response = await QueryAutocompleteRequest(
        key: tKey, 
        input: tInput, 
        httpClient: mockHttpClient
      ).call();
      ///assert
      verify(mockHttpClient.get(any));
      expect(response.status.status, 'ZERO_RESULTS');
    });
  });

  test('should work normally with null error message', 
  () {
    ///arrange
    
    ///act
    
    ///assert
    
  });
}