import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_google_places_api/core/utills/place_status.dart';
import 'package:flutter_google_places_api/requests/find_place_request.dart';
import 'package:flutter_google_places_api/responses/find_place_response.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

import '../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements Client {}

class MockFindPlaceRequest extends Mock implements FindPlaceRequest {}

void main() {
  MockHttpClient mockHttpClient;
  final utf8Header = {
    "content-type": "application/json; charset=utf-8"
  }; // for mcoking utf-8 charset http response
  final tKey = 'test_key';
  final tInput = 'test_input';
  final tInputType = 'phonenumber';
  final tUrl =
      'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=test_input&inputtype=phonenumber&fields=place_id&key=test_key';
  final tFields = ['place_id'];
  setUp(() {
    mockHttpClient = MockHttpClient();
  });

  group('find place request tests: ', () {
    test('build url', () {
      ///arrange
      var request = FindPlaceRequest(
        key: tKey,
        input: tInput,
        inputType: tInputType,
        fields: tFields,
      );

      ///act
      var url = request.buildUrl();

      ///assert
      expect(url, tUrl);
    });

    test('call', () async {
      ///arrange
      when(mockHttpClient.get(any)).thenAnswer((_) async => Response(
          fixture('find_place_response_test_data.json'), 200,
          headers: utf8Header));

      var tResponse = FindPlaceResponse(status: PlaceStatus(status: 'OK'));

      ///act
      var response = await FindPlaceRequest(
        key: null,
        input: null,
        inputType: null,
        httpClient: mockHttpClient,
      ).call();

      ///assert
      verify(mockHttpClient.get(any));
      expect(tResponse.status.status, equals(response.status.status));
    });
  });
}
