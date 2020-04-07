import 'dart:convert';
import 'package:flutter_google_places_api/requests/text_search_request.dart';
import 'package:flutter_google_places_api/responses/text_search_response.dart';
import 'package:http/http.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements Client {}

void main() {
  MockHttpClient mockHttpClient;
  final tUrl =
      'https://maps.googleapis.com/maps/api/place/textsearch/json?key=test_key&query=test+query';
  final tKey = 'test_key';
  final tQuery = 'test query';
  final utf8Header = {
    "content-type": "application/json; charset=utf-8"
  }; // for mcoking utf-8 charset http response

  setUp(() {
    mockHttpClient = MockHttpClient();
  });

  group('nearby search tests: ', () {
    test('build url', () {
      ///arrange
      var url = TextSearchRequest(
        key: tKey,
        query: tQuery,
        httpClient: mockHttpClient,
      ).buildUrl();

      ///assert
      expect(tUrl, url);
    });

    test('call', () async {
      ///arrange
      when(mockHttpClient.get(any)).thenAnswer((_) async => Response(
          fixture('text_search_test_data.json'), 200,
          headers: utf8Header));

      ///act
      var response = await TextSearchRequest(
        key: tKey,
        query: tQuery,
        httpClient: mockHttpClient,
      ).call();
      var tResponse = TextSearchResponse.fromJson(
          json.decode(fixture('text_search_test_data.json')));

      ///assert
      verify(mockHttpClient.get(any));
      expect(response, tResponse);
    });
  });
}
