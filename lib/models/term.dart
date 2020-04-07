import 'package:equatable/equatable.dart';

class Term extends Equatable {
  final int offset;
  final String value;

  Term(this.offset, this.value);

  factory Term.fromJson(Map map) =>
      map != null ? Term(map['offset'], map['value']) : null;

  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();
    map['offset'] = offset;
    map['value'] = value;
    return map;
  }

  @override
  String toString() {
    return toJson().toString();
  }

  @override
  List<Object> get props => null;
}
