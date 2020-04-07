import 'package:equatable/equatable.dart';
import 'package:flutter_google_places_api/models/model.dart';

class DebugLog extends Model with EquatableMixin {
  final List<String> line;
  DebugLog(this.line);

  factory DebugLog.fromJson(Map map) =>
      map != null ? DebugLog((map['line'] as List)?.cast<String>()) : null;

  @override
  List<Object> get props => [line];

  @override
  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();
    map['line'] = line;
    return map;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
