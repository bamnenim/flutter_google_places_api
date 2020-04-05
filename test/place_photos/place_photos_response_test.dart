import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart';
import 'package:google_places_api/responses/place_photos_response.dart';

import '../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements Client{}
class MockPlacePhotoResponse extends Mock implements PlacePhotoResponse{}

void main(){
  MockHttpClient mockHttpClient;
  final utf8Header = {
    "content-type":"application/json; charset=utf-8"
  }; // for mcoking utf-8 charset http response
  setUp(() {
    mockHttpClient = MockHttpClient();
  });

  test('description', 
  ()  {

  });
}