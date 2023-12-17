// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TodayModel {
  String grateful;
  String learned;
  String appreciated;
  String delighted;
  String date;
  TodayModel(
      {required this.grateful,
      required this.learned,
      required this.appreciated,
      required this.delighted,
      required this.date});

  TodayModel copyWith({
    String? grateful,
    String? learned,
    String? appreciated,
    String? delighted,
    String? date,
  }) {
    return TodayModel(
      grateful: grateful ?? this.grateful,
      learned: learned ?? this.learned,
      appreciated: appreciated ?? this.appreciated,
      delighted: delighted ?? this.delighted,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'grateful': grateful,
      'learned': learned,
      'appreciated': appreciated,
      'delighted': delighted,
      'date': date,
    };
  }

  factory TodayModel.fromMap(Map<String, dynamic> map) {
    return TodayModel(
      grateful: map['grateful'] as String,
      learned: map['learned'] as String,
      appreciated: map['appreciated'] as String,
      delighted: map['delighted'] as String,
      date: map['date'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TodayModel.fromJson(String source) =>
      TodayModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
