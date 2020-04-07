import 'package:equatable/equatable.dart';
import 'package:flutter_google_places_api/models/model.dart';

class DayTime extends Model with EquatableMixin {
  final int day;
  final String time;

  DayTime(this.day, this.time);

  factory DayTime.fromJson(Map map) =>
      map != null ? DayTime(map['day'], map['time']) : null;

  @override
  List<Object> get props => [day, time];

  @override
  Map<String, dynamic> toJson() => {
        "day": day,
        "time": time,
      };
}
