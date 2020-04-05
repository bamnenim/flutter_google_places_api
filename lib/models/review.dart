import 'package:equatable/equatable.dart';
import 'package:flutter_google_places_api/models/model.dart';
import 'package:meta/meta.dart';

class Review extends Model with EquatableMixin {
  final String authorName;
  final String authorUrl;
  final String language;
  final String profilePhotoUrl;
  final int rating;
  final String relativeTimeDescription;
  final String text;
  final int time;

  Review({
    @required this.authorName,
    @required this.authorUrl,
    @required this.language,
    @required this.profilePhotoUrl,
    @required this.rating,
    @required this.relativeTimeDescription,
    @required this.text,
    @required this.time,
  });

  factory Review.fromJson(Map map) => map != null
      ? Review(
          authorName: map['author_name'],
          authorUrl: map['author_url'],
          language: map['language'],
          profilePhotoUrl: map['profile_photo_url'],
          rating: map['rating'],
          relativeTimeDescription: map['relative_time_description'],
          text: map['text'],
          time: map['time'],
        )
      : null;

  @override
  List<Object> get props => [
        authorName,
        authorUrl,
        language,
        profilePhotoUrl,
        rating,
        relativeTimeDescription,
        text,
        time
      ];

  @override
  Map<String, dynamic> toJson() => {
        "author_name": authorName,
        "author_url": authorUrl,
        "language": language,
        "profile_photo_url": profilePhotoUrl,
        "rating": rating,
        "relative_time_description": relativeTimeDescription,
        "text": text,
        "time": time,
      };
}
