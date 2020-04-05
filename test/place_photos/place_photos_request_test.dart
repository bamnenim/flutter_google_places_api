import 'dart:typed_data';

import 'package:flutter_google_places_api/requests/place_photos_request.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockHttpClient extends Mock implements Client{}
class MockPlacePhotoRequest extends Mock implements PlacePhotoRequest{}

void main() {
  MockHttpClient mockHttpClient;
  MockPlacePhotoRequest mockPlacePhotoRequest;
  final utf8Header = {
    "content-type":"application/json; charset=utf-8"
  }; // for mcoking utf-8 charset http response
  final tUnit = Uint8List(2);
  final tKey = 'test_key';
  final tPhotoReference = 'test_photoreference';
  final tUrl = 'https://maps.googleapis.com/maps/api/place/photo?key=test_key&photoreference=test_photoreference&maxheight=1600&maxwidth=400';

  setUp(() {
    mockHttpClient = MockHttpClient();
    mockPlacePhotoRequest = MockPlacePhotoRequest();
  });

  test('build url', 
  () {
    ///arrange
    var request = PlacePhotoRequest(
      key: tKey, 
      photoReference: tPhotoReference,
      maxWidth: 400
    );
    ///act
    var url = request.buildUrl();
    ///assert
    expect(url, tUrl);
  });

  test('call', 
  () async {
    ///arrange
    when(mockHttpClient.get(any))
    .thenAnswer((_) async => Response.bytes(tUnit, 200, headers: utf8Header));
    ///act
    var response = await PlacePhotoRequest(
      key: null, 
      photoReference: null,
      httpClient: mockHttpClient
    ).call();
    ///assert
    verify(mockHttpClient.get(any));
    expect(response.imageByte, tUnit);
  });
}