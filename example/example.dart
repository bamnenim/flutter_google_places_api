import 'package:flutter_google_places_api/flutter_google_places_api.dart';

void main() async {
  var key = 'YOUR_API_KEY';
  var input = 'YOUR_INPUT_HERE';
  var response = await PlaceAutocompleteRequest(key: key, input: input).call();
  print(response.predictions[0].description);
}