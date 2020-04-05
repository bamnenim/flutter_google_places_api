import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:google_places_api/core/utills/place_status.dart';
import 'package:google_places_api/models/place_details_result.dart';
import 'package:google_places_api/requests/place_details_request.dart';
import 'package:mockito/mockito.dart';
import 'package:google_places_api/responses/place_details_response.dart';
import 'package:http/http.dart';

import '../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements Client{}
class MockPlaceDetailsResponse extends Mock implements PlaceDetailsResponse{}

void main() {
  MockHttpClient mockHttpClient;
  final utf8Header = {
    "content-type":"application/json; charset=utf-8"
  }; // for mcoking utf-8 charset http response

  setUp(() {
    mockHttpClient = MockHttpClient();
  });

  group('place details response group: ',
  () {
    test('should return response obj when it is made from json response', 
    () {
      ///arrange
      var jsonMap = json.decode(fixture('place_details_test_data.json'));
      var tResponseFromJson = PlaceDetailsResponse.fromJson(jsonMap);
      ///act
      var tResponseFromObj = PlaceDetailsResponse(
        status: PlaceStatus(status: 'OK'),
        htmlAttributions: [],
        result: PlaceDetailsResult.fromJson(jsonMap['result']),
      );
      ///assert
      expect(tResponseFromJson, equals(tResponseFromObj));
    });

    test('should return error response when it is made from json error response', 
    () {
      ///arrange
      var jsonMap = fixture('details_invalid_request.json');
      var tResponseFromJson = PlaceDetailsResponse.fromJson(json.decode(jsonMap));
      ///act
      var tResponseFromObj = PlaceDetailsResponse(
        status: PlaceStatus(
          status: "INVALID_REQUEST",
        ),
        htmlAttributions: []
      );
      ///assert
      expect(tResponseFromJson, tResponseFromObj);
    });
  });

  group('response with request',
  () {
    test('should return place details response with full result when the call is succesful', 
    () async {
      ///arrange
      when(mockHttpClient.get(any))
      .thenAnswer((_) async => Response(
        fixture('place_details_test_data.json'),
        200,
        headers: utf8Header,
      ));
      ///act
      var response = await PlaceDetailsRequest(
        key: null,
        placeId: null,
        httpClient: mockHttpClient
      ).call();

      var tResponse = PlaceDetailsResponse.fromJson(json.decode(fixture('place_details_test_data.json')));
      ///assert
      verify(mockHttpClient.get(any));
      expect(response, tResponse);
    });

    test('should return error status when the call is unsuccessful', 
    () async {
      ///arrange
      when(mockHttpClient.get(any))
      .thenAnswer((_) async => Response(
        fixture('details_invalid_request.json'),
        404,
        headers: utf8Header,
      ));
      ///act
      var response = await PlaceDetailsRequest(
        key: null, 
        placeId: null,
        httpClient: mockHttpClient,
      ).call();

      var tResponse = PlaceDetailsResponse.fromJson(
        json.decode(fixture('details_invalid_request.json')));
      ///assert
      verify(mockHttpClient.get(any));
      expect(response, tResponse);
    });
  });
}