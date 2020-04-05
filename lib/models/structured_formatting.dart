import 'package:equatable/equatable.dart';
import 'package:google_places_api/models/matched_substrings.dart';

class StructuredFormatting extends Equatable{
  final String mainText;
  final List<MatchedSubstring> mainTextMatchedSubstrings;
  final String secondaryText;
  final List<MatchedSubstring> secondaryTextMatchedSubstrings;

  StructuredFormatting({
    this.mainText,
    this.mainTextMatchedSubstrings,
    this.secondaryText,
    this.secondaryTextMatchedSubstrings,
  });

  factory StructuredFormatting.fromJson(Map map) => 
    map != null ? StructuredFormatting(
      mainText : map['main_text'],
      mainTextMatchedSubstrings: map['main_text_matched_substrings']
      ?.map((p) => MatchedSubstring.fromJson(p))
      ?.toList()
      ?.cast<MatchedSubstring>(),
      secondaryText: map['secondary_text'],
      secondaryTextMatchedSubstrings: map['secondary_text_matched_substrings']
      ?.map((p) => MatchedSubstring.fromJson(p))
      ?.toList()
      ?.cast<MatchedSubstring>(),
    ) : null;

  Map<String,dynamic> toJson() {
    var map = Map<String, dynamic>();
    map['main_text'] = mainText;
    map['main_text_matched_substrings'] = mainTextMatchedSubstrings?.map((p)=>p.toJson())?.toList();
    map['secondary_text'] = secondaryText;
    if(secondaryTextMatchedSubstrings != null)
      map['secondary_text_matched_substrings'] = secondaryTextMatchedSubstrings?.map((p)=>p.toJson())?.toList();
    return map;
  }

  @override
  String toString() {
    return toJson().toString();
  }

  @override
  List<Object> get props => 
    [mainText, mainTextMatchedSubstrings, secondaryText, secondaryTextMatchedSubstrings];
}