import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart';
import 'package:flutter_google_places_api/responses/place_photos_response.dart';

class MockHttpClient extends Mock implements Client {}

class MockPlacePhotoResponse extends Mock implements PlacePhotoResponse {}

void main() {
  test('description', () {});
}
