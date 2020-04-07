import 'package:equatable/equatable.dart';
import 'package:flutter_google_places_api/models/day_time.dart';
import 'package:flutter_google_places_api/models/model.dart';

class Period extends Model with EquatableMixin {
  final DayTime open;
  final DayTime close;

  Period(this.open, this.close);

  factory Period.fromJson(Map map) => map != null
      ? Period(
          DayTime.fromJson(map['open']),
          DayTime.fromJson(map['close']),
        )
      : null;

  @override
  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();
    map['open'] = open.toJson();
    if (close != null) map['close'] = close.toJson();
    return map;
  }

  @override
  List<Object> get props => [open, close];
}
