import 'dart:convert';
import 'package:flutter_google_places_api/responses/find_place_response.dart';
import 'package:flutter_test/flutter_test.dart';
import '../fixtures/fixture_reader.dart';

void main() {
  group('find place request test', () {
    var tResponseJson =
        json.decode(fixture('find_place_response_test_data.json'));
    test('fromJson test', () {
      ///arrange
      var tResponse = FindPlaceResponse.fromJson(tResponseJson);

      ///assert
      expect(tResponse.status.status, 'OK');
    });

    test('toJson test', () {
      ///arrange
      var tResponseFromToJson =
          FindPlaceResponse.fromJson(tResponseJson).toJson();

      ///assert
      expect(tResponseJson, equals(tResponseFromToJson));
    });
  });
}
