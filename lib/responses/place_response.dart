import 'package:google_places_api/core/utills/place_status.dart';
import 'package:meta/meta.dart';

abstract class PlaceResponse {
  final PlaceStatus status;
  PlaceResponse({
    @required this.status,
  });
}