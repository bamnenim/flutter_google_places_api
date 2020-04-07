import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter_google_places_api/responses/place_response.dart';

class PlacePhotoResponse extends PlaceResponse with EquatableMixin {
  final Uint8List imageByte;
  PlacePhotoResponse(this.imageByte);

  @override
  List<Object> get props => null;

  @override
  String toString() {
    return imageByte.toString();
  }
}
