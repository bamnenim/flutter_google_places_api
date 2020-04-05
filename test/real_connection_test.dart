import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_places_api/requests/find_place_request.dart';
import 'package:google_places_api/requests/place_autocomplete_request.dart';
import 'package:google_places_api/requests/place_details_request.dart';
import 'package:google_places_api/requests/place_photos_request.dart';
import 'package:google_places_api/requests/query_autocomplete_request.dart';
import 'package:google_places_api/responses/place_autocomplete_response.dart';
import 'package:google_places_api/responses/place_details_response.dart';
import 'fixtures/fixture_reader.dart';

void main() {
  group('test group for real connection test', 
  () {
    final key = 'AIzaSyBK9mz3Dru8bXJSRfWzzc2-JjVJ0R0xjdk';
    final input = 'hkust';
    final placeId = 'ChIJFX6cwWsEBDQRvkH4nI_V7Ss'; // hkust
    final photoReference = 'CmRaAAAAbWKkJiM7aiKatHh7ZJJV7WO2lXY1FZ53M1QGWWgbXC5rg0PnMs_YAdMTWnRF1B7TVrjRtz6yvC4Kjevisd_msWhZl88u6-LkyedhhV4XwRoP_PlqvPop3vvuTY7M7BJTEhBzD1xQDxldtHCzCwftVpHiGhRtD3_3xJUIhTLNO1FdWchaNz34Dg';

    test('place autocomplete', 
    () async {
      var response = await PlaceAutocompleteRequest(
        key: key, 
        input: input,
      ).call();
      var expectedResponse = PlaceAutocompleteResponse.fromJson(json.decode(fixture('place_autocomplete_test_data.json')));
      expect(response, equals(expectedResponse));
    });

    test('place details', 
    () async {
      var response = await PlaceDetailsRequest(
        key: key, 
        placeId: placeId
      ).call();
      var expectedResponse = PlaceDetailsResponse.fromJson(json.decode(fixture('place_details_test_data.json')));
      print(response.toString());
      expect(response, equals(expectedResponse));
    });

    test('place search', 
    () async {
      var response = await FindPlaceRequest(
        key: key, 
        input: input,
        inputType: 'textquery'
      ).call();
      print(response.toString()); // should print json-form text result
      expect(response.status.status, "OK");
    });

    test('place search', 
    () async {
      var response = await FindPlaceRequest(
        key: key, 
        input: input,
        inputType: 'textquery'
      ).call();
      print(response.toString()); // should print json-form text result
      expect(response.status.status, "OK");
    });

    test('place search', 
    () async {
      var response = await FindPlaceRequest(
        key: key, 
        input: input,
        inputType: 'textquery'
      ).call();
      print(response.toString()); // should print json-form text result
      expect(response.status.status, "OK");
    });

    test('place photos', 
    () async {
      var response = await PlacePhotoRequest(
        key: key, 
        photoReference: photoReference
      ).call();
      print(response.toString()); // should print json-form text result
    });

    test('query autocomplete', 
    () async {
      var response = await QueryAutocompleteRequest(
        key: key, 
        input: input
      ).call();
      print(response.toString()); // should print json-form text result
      expect(response.status.status, "OK");
    });
  });
}

