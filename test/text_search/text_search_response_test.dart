import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_google_places_api/responses/text_search_response.dart';
import '../fixtures/fixture_reader.dart';

void main() {
  group('find place request test', () {

    var tResponseJson = json.decode(fixture('text_search_test_data.json'));
    test('fromJson test', () {
      ///arrange
      var tResponse = TextSearchResponse.fromJson(tResponseJson);
      ///assert
      expect(tResponse.status.status, equals('OK'));
    });

    test('toJson test', () {
      ///arrange
      var tResponseFromToJson = TextSearchResponse.fromJson(tResponseJson).toJson();
      ///assert
      expect(tResponseJson, equals(tResponseFromToJson));
    });
  });
}