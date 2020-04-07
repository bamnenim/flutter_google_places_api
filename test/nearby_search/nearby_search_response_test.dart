import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_google_places_api/responses/nearby_search_response.dart';
import '../fixtures/fixture_reader.dart';

void main() {
  group('nearby search request test', () {
    var tResponseJson = json.decode(fixture('nearby_search_test_data.json'));
    test('fromJson test', () {
      ///arrange
      var tResponse = NearbySearchResponse.fromJson(tResponseJson);

      ///assert
      expect(tResponse.status.status, equals('OK'));
    });

    test('toJson test', () {
      ///arrange
      var tResponseFromJson = NearbySearchResponse.fromJson(tResponseJson);

      ///assert
      expect(tResponseJson, equals(tResponseFromJson.toJson()));
    });
  });
}
