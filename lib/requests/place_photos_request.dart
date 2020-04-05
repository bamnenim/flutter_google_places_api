import 'package:google_places_api/requests/places_request.dart';
import 'package:google_places_api/responses/place_photos_response.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

class PlacePhotoRequest extends PlacesRequest{
  final String key;
  final String photoReference;
  num maxHeight;
  num maxWidth;
  Client httpClient;

  PlacePhotoRequest({
    @required this.key, 
    @required this.photoReference, 
    this.maxHeight = 1600, 
    this.maxWidth = 1600,
    this.httpClient,
  }) : super(
    key: key,
    url: 'photo',
    httpClient: httpClient
  ) {
    httpClient ??= Client();
  }

  @override
  String buildUrl() {
    var queryString = super.buildQuery(getQueryParams());
    return '$url$queryString';
  }

  @override
  Future<PlacePhotoResponse> call() async =>
    PlacePhotoResponse((await getHttpFrom(buildUrl())).bodyBytes);

  @override
  Map<String, dynamic> getQueryParams() {
    var params = {
      'key': key,
      'photoreference': photoReference,
      'maxheight': maxHeight,
      'maxwidth': maxWidth,
    };
    return params;
  }
  
}