import 'package:equatable/equatable.dart';
import 'package:google_places_api/models/model.dart';

class Photo  extends Model with EquatableMixin{
  
  final int height;
  final List<String> htmlAttributions;
  final String photoReference;
  final int width;

  Photo({
    this.height, 
    this.htmlAttributions, 
    this.photoReference, 
    this.width
  });

  factory Photo.fromJson(Map map) =>
    map != null ? Photo(
      height: map['height'],
      htmlAttributions: (map['html_attributions'] as List)?.cast<String>(),
      photoReference: map['photo_reference'],
      width: map['width']
    ) : null;

  @override
  List<Object> get props => [height, htmlAttributions, photoReference, width];

  @override
  Map<String, dynamic> toJson() => {
    "height": height,
    "html_attributions": htmlAttributions,
    "photo_reference": photoReference,
    "width": width,
  };
}