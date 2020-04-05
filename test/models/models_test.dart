import 'dart:convert';
import 'package:flutter_google_places_api/models/address_component.dart';
import 'package:flutter_google_places_api/models/candidate.dart';
import 'package:flutter_google_places_api/models/components.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_google_places_api/models/day_time.dart';
import 'package:flutter_google_places_api/models/geometry.dart';
import 'package:flutter_google_places_api/models/location.dart';
import 'package:flutter_google_places_api/models/matched_substrings.dart';
import 'package:flutter_google_places_api/models/nearby_search_result.dart';
import 'package:flutter_google_places_api/models/opening_hours.dart';
import 'package:flutter_google_places_api/models/period.dart';
import 'package:flutter_google_places_api/models/photo.dart';
import 'package:flutter_google_places_api/models/place_details_result.dart';
import 'package:flutter_google_places_api/models/plus_code.dart';
import 'package:flutter_google_places_api/models/review.dart';
import 'package:flutter_google_places_api/models/structured_formatting.dart';
import 'package:flutter_google_places_api/models/term.dart';
import 'package:flutter_google_places_api/models/text_search_result.dart';
import 'package:flutter_google_places_api/models/viewport.dart';
import 'package:flutter_google_places_api/requests/place_autocomplete_request.dart';
import 'package:flutter_google_places_api/responses/find_place_response.dart';
import 'package:flutter_google_places_api/responses/nearby_search_response.dart';
import 'package:flutter_google_places_api/responses/place_autocomplete_response.dart';
import 'package:flutter_google_places_api/responses/place_details_response.dart';
import 'package:flutter_google_places_api/responses/query_autocomplete_response.dart';

import '../fixtures/fixture_reader.dart';

void main() {
  group('model test group : ', () {
    group('componetns ', () {
      test('components to string', () {
        ///arrange
        var components = Components(comp: ['kr', 'fr', 'us', 'cn', 'jp']);
        ///act
        var queryString = components.toString();
        var tQuery = 'country:kr|country:fr|country:us|country:cn|country:jp';
        ///assert
        expect(queryString, tQuery);
      });

      test('components equality test', () {
        ///arrange
        var components1 = Components(comp: ['kr','fr','us']);
        var components2 = Components(comp: ['fr','us','kr']);
        var components3 = Components(comp: ['kr']);
        var components4 = Components(comp: ['jp','us','kr']);
        var components5 = Components(comp: ['jp','jp','jp']);

        ///assert
        expect(components1, equals(components2));
        expect(components1, isNot(equals(components3)));
        expect(components1, isNot(equals(components4)));
        expect(components1, isNot(equals(components5)));
        expect(components4, isNot(equals(components5)));
      });
    });
    group('query prediction  ', () {
      test('query prediction fromJson test', () {
        ///arrange
        var tQueryAutocomplete = json.decode(fixture('query_autocomplete_test_data.json'));
        var tQueryPrediction = QueryAutocompleteResponse.fromJson(tQueryAutocomplete).predictions[0];

        ///assert
        expect(tQueryPrediction.description, equals('pizza near North Houston Airport, Airfield Lane, Porter, TX, USA'));
        expect(tQueryPrediction.matchedSubstrings[0].length, equals(5));
        expect(tQueryPrediction.structuredFormatting.mainTextMatchedSubstrings[0].length, equals(5));
        expect(tQueryPrediction.terms[0].value, equals('pizza'));
      });
      
      test('query prediction toJson test', () {
        ///arrange
        var tQueryAutocomplete = json.decode(fixture('query_autocomplete_test_data.json'));
        var tQueryPrediction = QueryAutocompleteResponse.fromJson(tQueryAutocomplete).predictions[0];
        Map<String, dynamic> tQueryPredictionJson = tQueryAutocomplete['predictions'][0];

        ///assert
        expect(tQueryPredictionJson, equals(tQueryPrediction.toJson()));
      });
    });
    group('matched substring  ', () {
      test('matched substring from json test', () {
        ///arrange
        var tMatchedSubstringJson = {
                  "length": 5,
                  "offset": 0
              };
        ///act
        var tMatchedSubstring = MatchedSubstring.fromJson(tMatchedSubstringJson);
        ///assert
        expect(tMatchedSubstring.length, equals(5));
        expect(tMatchedSubstring.offset, equals(0));
      });

      test('matched substring to json, to string test', () {
        ///arrange
        var tMatchedSubstringJson = {
                  "length": 5,
                  "offset": 0
              };
        ///act
        var tMatchedSubstring = MatchedSubstring.fromJson(tMatchedSubstringJson);
        ///assert
        expect(tMatchedSubstringJson, equals(tMatchedSubstring.toJson()));
      });
    });
    group('term  ', () {
      test('term from json test', () {
        ///arrange
        var tTermJson = {
                  "offset": 0,
                  "value": "pizza"
              };
        ///act
        var tTerm = Term.fromJson(tTermJson);
        ///assert
        expect(tTerm.offset, equals(0));
        expect(tTerm.value, equals('pizza'));
      });

      test('term to json and to string test', () {
        ///arrange
        var tTermJson = {
                  "offset": 0,
                  "value": "pizza"
              };
        ///act
        var tTerm = Term.fromJson(tTermJson);
        ///assert
        expect(tTermJson, equals(tTerm.toJson()));
      });
    });
    group('structured formatting ', () {
      var tStructuredFormattingJson = {
              "main_text": "pizza",
              "main_text_matched_substrings": [
                  {
                    "length": 5,
                    "offset": 0
                  }
              ],
              "secondary_text": "near North Houston Airport, Airfield Lane, Porter, TX, USA",
              "secondary_text_matched_substrings": [
                  {
                    "length": 21,
                    "offset": 5
                  }
              ]
            };
      test('structured formatting from json test', () {
        ///arrange
        var tStructuredFormatting = StructuredFormatting.fromJson(tStructuredFormattingJson);
        ///assert
        expect(tStructuredFormatting.mainText, equals('pizza'));
        expect(tStructuredFormatting.secondaryText, equals('near North Houston Airport, Airfield Lane, Porter, TX, USA'));
        expect(tStructuredFormatting.mainTextMatchedSubstrings[0].length, equals(5));
        expect(tStructuredFormatting.secondaryTextMatchedSubstrings[0].length, equals(21));
      });

      test('structured formatting to json and to String test', () {
        ///arrange
        var tStructuredFormatting = StructuredFormatting.fromJson(tStructuredFormattingJson);
        ///assert
        expect(tStructuredFormattingJson, equals(tStructuredFormatting.toJson()));
      });
    });
    
    group('place prediction ', () {
      test('place prediction fromJson test', () {
        ///arrange
        var tPlaceAutocomplete = json.decode(fixture('place_autocomplete_test_data.json'));
        var tPlacePrediction = PlaceAutocompleteResponse.fromJson(tPlaceAutocomplete).predictions[0];

        ///assert
        expect(tPlacePrediction.description, equals('Hong Kong University of Science and Technology, Clear Water Bay, Hong Kong'));
        expect(tPlacePrediction.matchedSubstrings[0].length, equals(46));
        expect(tPlacePrediction.structuredFormatting.mainTextMatchedSubstrings[0].length, equals(46));
        expect(tPlacePrediction.terms[0].value, equals('Hong Kong University of Science and Technology'));
      });

      test('place prediction toJson test', () {
        ///arrange
        var tQueryAutocomplete = json.decode(fixture('place_autocomplete_test_data.json'));
        var tQueryPrediction = PlaceAutocompleteResponse.fromJson(tQueryAutocomplete).predictions[0];
        Map<String, dynamic> tQueryPredictionJson = tQueryAutocomplete['predictions'][0];

        ///assert
        expect(tQueryPredictionJson, equals(tQueryPrediction.toJson()));
      });
    });
    
    var tViewpointJson =  {
        "northeast": {
          "lat": 22.34225680000001,
          "lng": 114.2673714
        },
        "southwest": {
          "lat": 22.32966279999999,
          "lng": 114.2597478
        }
      };
    group('viewport ', () {
      

      test('viewpoint from json test', () {
        ///arrange
        var tViewpointFromJson = Viewport.fromJson(tViewpointJson);
        var tViewpoint = Viewport(
          Location(lat: 22.34225680000001, lng: 114.2673714),
          Location(lat: 22.32966279999999, lng: 114.2597478),
        );
        ///assert
        expect(tViewpoint, equals(tViewpointFromJson));
      });

      test('viewpoint to json test', () {
        ///arrange
        var tViewpoint = Viewport.fromJson(tViewpointJson);
        ///assert
        expect(tViewpointJson, equals(tViewpoint.toJson()));
      });
    });
    
    group('geometry ', () {
      var tGeometryJson = {
        "location": {
          "lat": 22.3363998,
          "lng": 114.2654655
        },
        "viewport": {
          "northeast": {
              "lat": 22.34225680000001,
              "lng": 114.2673714
          },
          "southwest": {
              "lat": 22.32966279999999,
              "lng": 114.2597478
          }
        }
      };

      test('geometry from Json test', () {
        ///arrange
        var tGeometryFromJson = Geometry.fromJson(tGeometryJson);
        var tGeometry = Geometry(
          location: Location(
            lat: 22.3363998, 
            lng: 114.2654655
          ),
          viewport: Viewport.fromJson(tViewpointJson),
        );
        ///assert
        expect(tGeometryFromJson, equals(tGeometry));
      });

      test('geometry to json test', () {
        ///arrange
        var tGeomerty = Geometry.fromJson(tGeometryJson);
        ///assert
        expect(tGeometryJson, equals(tGeomerty.toJson()));
      });
    });

    group('opening hours ', () {
      var tOpeningHoursJson = {
        "open_now": false,
        "periods": [
          {
              "close": {
                "day": 6,
                "time": "0000"
              },
              "open": {
                "day": 1,
                "time": "0000"
              }
          }
        ],
        "weekday_text": [
          "Monday: Open 24 hours",
          "Tuesday: Open 24 hours",
          "Wednesday: Open 24 hours",
          "Thursday: Open 24 hours",
          "Friday: Open 24 hours",
          "Saturday: Closed",
          "Sunday: Closed"
        ]
      };

      test('opening hours from Json test', () {
        ///arrange
        var tOpeningHoursFromJson = OpeningHours.fromJson(tOpeningHoursJson);
        var tOpeningHours = OpeningHours(
          openNow: false,
          periods: [Period(DayTime(1, '0000'), DayTime(6, '0000'))],
          weekdayText: tOpeningHoursJson["weekday_text"]
        );
        ///assert
        expect(tOpeningHoursFromJson, equals(tOpeningHours));
      });

      test('opening hours to json test', () {
        ///arrange
        var tOpeningHours = OpeningHours.fromJson(tOpeningHoursJson);
        ///assert
        expect(tOpeningHoursJson, equals(tOpeningHours.toJson()));
      });
    });

    group('day time ', () {
      var tDayTimeJson = {
        "day": 6,
        "time": "0000"
      };
      test('daytime from Json test', () {
        ///arrange
        var tDayTimeFromJson = DayTime.fromJson(tDayTimeJson);
        var tDayTime = DayTime(6, '0000');
        ///assert
        expect(tDayTime, equals(tDayTimeFromJson));
      });

      test('daytime to json test', () {
        ///arrange
        var tDayTime = DayTime.fromJson(tDayTimeJson);
        ///assert
        expect(tDayTimeJson, equals(tDayTime.toJson()));
      });
    });

    group(' ', () {
      var tPeriodJson = {
        "close": {
          "day": 6,
          "time": "0000"
        },
        "open": {
          "day": 1,
          "time": "0000"
        }
      };
      test('period from Json test', () {
        ///arrange
        var tPeriodFromJson = Period.fromJson(tPeriodJson);
        var tPeriod = Period(DayTime(1,'0000'), DayTime(6,'0000'));
        ///assert
        expect(tPeriodFromJson, equals(tPeriod));
      });

      test('period to json test', () {
        ///arrange
        var tPeriod = Period.fromJson(tPeriodJson);
        ///assert
        expect(tPeriodJson, equals(tPeriod.toJson()));
      });
    });

    group('photo ', () {
      var tPhotoJson = {
        "height": 2667,
        "html_attributions": [
            "\u003ca href=\"https://maps.google.com/maps/contrib/101584296985195388352\"\u003eCHENG WU\u003c/a\u003e"
        ],
        "photo_reference": "CmRaAAAAbWKkJiM7aiKatHh7ZJJV7WO2lXY1FZ53M1QGWWgbXC5rg0PnMs_YAdMTWnRF1B7TVrjRtz6yvC4Kjevisd_msWhZl88u6-LkyedhhV4XwRoP_PlqvPop3vvuTY7M7BJTEhBzD1xQDxldtHCzCwftVpHiGhRtD3_3xJUIhTLNO1FdWchaNz34Dg",
        "width": 4000
      };

      test('photo from Json test', () {
        ///arrange
        var tPhotoFromJson = Photo.fromJson(tPhotoJson);
        var tPhoto = Photo(
          height: 2667,
          htmlAttributions: tPhotoJson['html_attributions'],
          photoReference: tPhotoJson['photo_reference'],
          width: 4000,
        );
        ///assert
        expect(tPhotoFromJson, equals(tPhoto));
      });

      test('photo to json test', () {
        ///arrange
        var tPhoto = Photo.fromJson(tPhotoJson);
        ///assert
        expect(tPhotoJson, equals(tPhoto.toJson()));
      });
    });

    group('plus code ', () {
      var tPlusCodeJson = {
        "compound_code": "87P8+H5 Hong Kong",
        "global_code": "7PJP87P8+H5"
      };

      test('plus code from Json test', () {
        ///arrange
        var tPlusCodeFromJson = PlusCode.fromJson(tPlusCodeJson);
        var tPlusCode = PlusCode(
          compoundCode: '87P8+H5 Hong Kong',
          globalCode: '7PJP87P8+H5'
        );
        ///assert
        expect(tPlusCodeFromJson, equals(tPlusCode));
      });

      test('plus code to json test', () {
        ///arrange
        var tPlusCode = PlusCode.fromJson(tPlusCodeJson);
        ///assert
        expect(tPlusCodeJson, equals(tPlusCode.toJson()));
      });
    });
    
    var tReviewJson = {
        "author_name": "Cheung Samuel",
        "author_url": "https://www.google.com/maps/contrib/114046268441650505584/reviews",
        "language": "en",
        "profile_photo_url": "https://lh6.ggpht.com/-xK8JBWD9PlE/AAAAAAAAAAI/AAAAAAAAAAA/t4UK9HqY5Fc/s128-c0x00000000-cc-rp-mo-ba4/photo.jpg",
        "rating": 5,
        "relative_time_description": "a year ago",
        "text": "The school is well designed. Near the coast, the building has a unique shape that facilitates intensive air flow, so the place becomes windy most of the time. However, the school is far from the town, which you need bus to come and leave.",
        "time": 1552648634
      };
    group('review ', () {
      test('review from Json test', () {
        ///arrange
        var tReviewFromJson = Review.fromJson(tReviewJson);
        var tReview = Review(
          authorName: 'Cheung Samuel',
          authorUrl: 'https://www.google.com/maps/contrib/114046268441650505584/reviews',
          language: 'en',
          profilePhotoUrl: 'https://lh6.ggpht.com/-xK8JBWD9PlE/AAAAAAAAAAI/AAAAAAAAAAA/t4UK9HqY5Fc/s128-c0x00000000-cc-rp-mo-ba4/photo.jpg',
          rating: 5,
          relativeTimeDescription: 'a year ago',
          text: 'The school is well designed. Near the coast, the building has a unique shape that facilitates intensive air flow, so the place becomes windy most of the time. However, the school is far from the town, which you need bus to come and leave.',
          time: 1552648634
        );
        ///assert
        expect(tReviewFromJson, equals(tReview));
      });

      test('review to json test', () {
        ///arrange
        var tReview = Review.fromJson(tReviewJson);
        ///assert
        expect(tReviewJson, equals(tReview.toJson()));
      });
    });

    var tAddressComponentJson = {
        "long_name": "Clear Water Bay",
        "short_name": "Clear Water Bay",
        "types": [
            "neighborhood",
            "political"
        ]
      };
    group('address component ', () {
      test('address component from Json test', () {
        ///arrange
        var tAddressComponentFromJson = AddressComponent.fromJson(tAddressComponentJson);
        var tAddressComponent = AddressComponent(
          longName: "Clear Water Bay",
          shortName: "Clear Water Bay",
          types: ["neighborhood", "political"]
        );
        ///assert
        expect(tAddressComponentFromJson, equals(tAddressComponent));
      });

      test('address component to json test', () {
        ///arrange
        var tAddressComponent = AddressComponent.fromJson(tAddressComponentJson);
        ///assert
        expect(tAddressComponentJson, equals(tAddressComponent.toJson()));
      });
    });

    group(' place details result', () {
      var tPlaceDetailsResultJson = json.decode(fixture('place_details_test_data.json'))['result'];
      var rPlaceDetailsResultTestJson = {
        "address_components": [
          {
            "long_name": "Clear Water Bay",
            "short_name": "Clear Water Bay",
            "types": [
                "neighborhood",
                "political"
            ]
          }
        ],
        "name": 'test',
        "reviews": [
          {
            "author_name": "Cheung Samuel",
            "author_url": "https://www.google.com/maps/contrib/114046268441650505584/reviews",
            "language": "en",
            "profile_photo_url": "https://lh6.ggpht.com/-xK8JBWD9PlE/AAAAAAAAAAI/AAAAAAAAAAA/t4UK9HqY5Fc/s128-c0x00000000-cc-rp-mo-ba4/photo.jpg",
            "rating": 5,
            "relative_time_description": "a year ago",
            "text": "The school is well designed. Near the coast, the building has a unique shape that facilitates intensive air flow, so the place becomes windy most of the time. However, the school is far from the town, which you need bus to come and leave.",
            "time": 1552648634
          }
        ]
        
      };
      test('place details result from Json test', () {
        ///arrange
        var tPlaceDetailsResultFromJson = PlaceDetailsResult.fromJson(rPlaceDetailsResultTestJson);
        var tPlaceDetailsResult = PlaceDetailsResult(
          addressComponents: [AddressComponent.fromJson(tAddressComponentJson)], 
          name: 'test', 
          reviews: [Review.fromJson(tReviewJson)],
        );
        ///assert
        expect(tPlaceDetailsResultFromJson, equals(tPlaceDetailsResult));
      });

      test('place details result to json test', () {
        ///arrange
        var tPlaceDetailsResultFromJson = PlaceDetailsResult.fromJson(tPlaceDetailsResultJson);
        ///assert
        expect(tPlaceDetailsResultJson, equals(tPlaceDetailsResultFromJson.toJson()));
      });
    });

    group('candidate ', () {
      var tCandidateJson = json.decode(fixture('find_place_response_test_data.json'))["candidates"][0];

      test('candidate from json', () {
        ///arrange
        var tCandidateFromJson = Candidate.fromJson(tCandidateJson);
        var tCandidateObj = Candidate(
          formattedAddress: "140 George St, The Rocks NSW 2000, Australia",
          geometry: Geometry(
            location: Location(lat: -33.8599358, lng: 151.2090295),
            viewport: Viewport(
              Location(lat: -33.85824767010727, lng: 151.2102470798928), 
              Location(lat: -33.86094732989272, lng: 151.2075474201073)
            )
          ),
          name: 'Museum of Contemporary Art Australia',
          openingHours: OpeningHours(
            openNow: false,
            weekdayText: []
          ),
          rating: 4.3
        );
        ///assert
        expect(tCandidateFromJson, equals(tCandidateObj));
      });

      test('candidate to json test', () {
        var tCandidate = Candidate.fromJson(tCandidateJson);
        expect(tCandidateJson, equals(tCandidate.toJson()));
      });
    });

    group('nearby search result ', () {
      var tNearbySearchResultJson = json.decode(fixture('nearby_search_test_data.json'))["results"][0];

      test('nearby search result from json test', () {
        ///arrange
        var tNearbySearchResultFromJson = NearbySearchResult.fromJson(tNearbySearchResultJson);
        var tNearbySearchResult = NearbySearchResult(
          geometry: Geometry(
            location: Location(lat: 22.31920109999999, lng: 114.1696121),
            viewport: Viewport(
              Location(lat: 22.561968, lng: 114.4294999), 
              Location(lat: 22.1435, lng: 113.8259001)
            )
          ),
          icon: 'https://maps.gstatic.com/mapfiles/place_api/icons/geocode-71.png',
          id: 'e7837e254c7b5dd74314f5a165f6a5b7e9fe48ad',
          name: 'Hong Kong',
          placeId: 'ChIJByjqov3-AzQR2pT0dDW0bUg',
          reference: 'ChIJByjqov3-AzQR2pT0dDW0bUg',
          scope: 'GOOGLE',
          vicinity: 'Hong Kong',
        );
        ///assert
        expect(tNearbySearchResultFromJson, equals(tNearbySearchResult));
      });

      test('nearby search result to json test', () {
        ///arrange
        var tNearbySearchResultFromJson = NearbySearchResult.fromJson(tNearbySearchResultJson);
        ///assert
        expect(tNearbySearchResultJson, equals(tNearbySearchResultFromJson.toJson()));
      });
    });

    group('text search result ', () {
      var tTextSearchResultJson = json.decode(fixture('text_search_test_data.json'))["results"][0];

      test('text search result from json test', () {
        ///arrange
        var tTextSearchResultFromJson = TextSearchResult.fromJson(tTextSearchResultJson);
        var tTextSearchResult = TextSearchResult(
          geometry: Geometry(
            location: Location(lat: 22.2829989, lng: 114.1370848),
            viewport: Viewport(
              Location(lat: 22.2848377, lng: 114.1412664), 
              Location(lat: 22.2799241, lng: 114.135058)
            )
          ),
          icon: 'https://maps.gstatic.com/mapfiles/place_api/icons/school-71.png',
          id: '9cd5a496d30470c65d51a9d6f6587d4f6228ff7a',
          name: 'The University of Hong Kong',
          openingHours: OpeningHours(),
          placeId: 'ChIJlzW0J4T_AzQR2MhvzdP1SCw',
          plusCode: PlusCode(globalCode: "7PJP74MP+5R",compoundCode: "74MP+5R Hong Kong")
        );
        ///assert
        expect(tTextSearchResultFromJson, equals(tTextSearchResult));
      });

      test('text search result to json test', () {
        ///arrange
        var tTextSearchResultFromJson = TextSearchResult.fromJson(tTextSearchResultJson);
        ///assert
        expect(tTextSearchResultJson, equals(tTextSearchResultFromJson.toJson()));
      });
    });
  
  
  });
}