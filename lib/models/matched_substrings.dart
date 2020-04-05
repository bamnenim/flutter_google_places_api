import 'package:equatable/equatable.dart';

class MatchedSubstring extends Equatable{
  final int length;
  final int offset;

  MatchedSubstring(this.length, this.offset);

  factory MatchedSubstring.fromJson(Map map) => 
    map != null ? MatchedSubstring(map['length'], map['offset']) : null;

  Map<String, dynamic> toJson() => 
    {
      'length': length,
      'offset': offset,
    };

  @override
  String toString() {
    return this.toJson().toString();
  }

  @override
  List<Object> get props => [length, offset];
}