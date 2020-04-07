import 'package:equatable/equatable.dart';
import 'package:flutter_google_places_api/models/model.dart';

class PlusCode extends Model with EquatableMixin {
  final String compoundCode;
  final String globalCode;

  PlusCode({this.compoundCode, this.globalCode});

  factory PlusCode.fromJson(Map map) => map != null
      ? PlusCode(
          compoundCode: map['compound_code'],
          globalCode: map['global_code'],
        )
      : null;

  @override
  List<Object> get props => [compoundCode, globalCode];

  @override
  Map<String, dynamic> toJson() =>
      {"compound_code": compoundCode, "global_code": globalCode};
}
