import 'package:equatable/equatable.dart';
import 'package:flutter_google_places_api/models/model.dart';
import 'package:flutter_google_places_api/models/period.dart';

class OpeningHours extends Model with EquatableMixin {
  final bool openNow;
  final List<Period> periods;
  final List<String> weekdayText;

  OpeningHours({this.openNow, this.periods, this.weekdayText});

  factory OpeningHours.fromJson(Map map) => map != null
      ? OpeningHours(
          openNow: map['open_now'],
          periods: map['periods'] != null
              ? map['periods']
                  ?.map((p) => Period.fromJson(p))
                  ?.toList()
                  ?.cast<Period>()
              : null,
          weekdayText: (map['weekday_text'] as List)?.cast<String>(),
        )
      : null;

  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();
    if (openNow != null) map["open_now"] = openNow;
    if (periods != null)
      map["periods"] = periods.map((p) => p.toJson()).toList();
    if (weekdayText != null) map["weekday_text"] = weekdayText;
    return map;
  }

  @override
  List<Object> get props => [openNow, periods, weekdayText];
}
