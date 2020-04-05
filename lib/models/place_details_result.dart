import 'package:equatable/equatable.dart';
import 'package:google_places_api/models/address_component.dart';
import 'package:google_places_api/models/geometry.dart';
import 'package:google_places_api/models/model.dart';
import 'package:google_places_api/models/opening_hours.dart';
import 'package:google_places_api/models/photo.dart';
import 'package:google_places_api/models/plus_code.dart';
import 'package:google_places_api/models/review.dart';
import 'package:meta/meta.dart';

class PlaceDetailsResult extends Model with EquatableMixin {
  final List<AddressComponent> addressComponents;
  final String adrAddress;
  final String formattedAddress;
  final String formattedPhoneNumber;
  final Geometry geometry;
  final String icon;
  final String id;
  final String internationalPhoneNumber;
  final String name;
  final OpeningHours openingHours;
  final bool permanentlyColosed;
  final List<Photo> photos;
  final String placeId;
  final PlusCode plusCode;
  final int priceLevel;
  final double rating;
  final String reference;
  final List<Review> reviews;
  final String scope;
  final List<String> types;
  final String url;
  final int userRatingsTotal;
  final int utcOffset;
  final String vicinity;
  final String website;

  PlaceDetailsResult({
    this.addressComponents,
    this.adrAddress,
    this.formattedAddress,
    this.formattedPhoneNumber,
    this.geometry,
    this.icon,
    this.id,
    this.internationalPhoneNumber,
    this.name,
    this.openingHours,
    this.permanentlyColosed,
    this.photos,
    this.placeId,
    this.plusCode,
    this.priceLevel,
    this.rating,
    this.reference,
    this.reviews,
    this.scope,
    this.types,
    this.url,
    this.userRatingsTotal,
    this.utcOffset,
    this.vicinity,
    this.website,
  });

  factory PlaceDetailsResult.fromJson(Map map) => 
    map != null ? PlaceDetailsResult(
      addressComponents: map['address_components']
        ?.map((p)=>AddressComponent.fromJson(p))
        ?.toList()
        ?.cast<AddressComponent>(), 
      adrAddress: map['adr_address'], 
      formattedAddress: map['formatted_address'], 
      formattedPhoneNumber: map['formatted_phone_number'], 
      geometry: map['geometry'] != null ? Geometry.fromJson(map['geometry']) : null, 
      icon: map['icon'], 
      id: map['id'], 
      internationalPhoneNumber: map['international_phone_number'], 
      name: map['name'], 
      openingHours: map['opening_hours'] != null? OpeningHours.fromJson(map['opening_hours']) : null, 
      permanentlyColosed: map['permanently_closed'], 
      photos: map['photos']
        ?.map((p)=>Photo.fromJson(p))
        ?.toList()
        ?.cast<Photo>(), 
      placeId: map['place_id'], 
      plusCode: map['plus_code'] != null ? PlusCode.fromJson(map['plus_code']) : null, 
      priceLevel: map['price_level'], 
      rating: map['rating'], 
      reference: map['reference'], 
      reviews: map['reviews']
        ?.map((p)=>Review.fromJson(p))
        ?.toList()
        ?.cast<Review>(), 
      scope: map['scope'], 
      types: (map['types'] as List)?.cast<String>(), 
      url: map['url'], 
      userRatingsTotal: map['user_ratings_total'], 
      utcOffset: map['utc_offset'], 
      vicinity: map['vicinity'], 
      website: map['website']
    ) : null;

  @override
  List<Object> get props => [
    addressComponents,
    adrAddress,
    formattedAddress,
    formattedPhoneNumber,
    geometry,
    icon,
    id,
    internationalPhoneNumber,
    name,
    permanentlyColosed,
    placeId,
    plusCode,
    priceLevel,
    rating,
    reference,
    scope,
    types,
    url,
    userRatingsTotal,
    utcOffset,
    vicinity,
    website
  ];

  @override
  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();
    map["address_components"] = addressComponents?.map((p)=>p.toJson())?.toList();
    map["adr_address"] = adrAddress; 
    map["formatted_address"] = formattedAddress; 
    map["formatted_phone_number"] = formattedPhoneNumber; 
    map["geometry"] = geometry?.toJson();
    map['icon'] = icon; 
    map['id'] = id; 
    map['international_phone_number'] = internationalPhoneNumber; 
    map['name'] = name;
    if(openingHours != null)
      map['opening_hours'] = openingHours?.toJson(); 
    map['permanently_closed'] = permanentlyColosed; 
    map['photos'] = photos?.map((p)=>p.toJson())?.toList();
    map['place_id'] = placeId; 
    map['plus_code'] = plusCode?.toJson();
    if(priceLevel != null)
      map['price_level'] = priceLevel; 
    map['rating'] = rating; 
    map['reference'] = reference; 
    map['reviews'] = reviews?.map((p)=>p.toJson())?.toList();
    map['scope'] = scope; 
    map['types'] = types; 
    map['url'] = url; 
    map['user_ratings_total'] = userRatingsTotal; 
    map['utc_offset'] = utcOffset; 
    map['vicinity'] = vicinity; 
    map['website'] = website;
    return map;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}