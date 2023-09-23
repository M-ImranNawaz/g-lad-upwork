class DailyRecordModel {
  int? id;
  String grateful;
  String learned;
  String appreciated;
  String delighted;
  String date;
  int? month;

  DailyRecordModel({
    this.id,
    required this.grateful,
    required this.learned,
    required this.appreciated,
    required this.delighted,
    required this.date,
    required this.month,

  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'grateful': grateful,
      'learned': learned,
      'appreciated': appreciated,
      'delighted': delighted,
      'date': date,
      'month': month
    };
  }

  factory DailyRecordModel.fromJson(Map<String, dynamic> json) {
    return DailyRecordModel(
      id: json['id'],
      grateful: json['grateful'],
      learned: json['learned'],
      appreciated: json['appreciated'],
      delighted: json['delighted'],
      date: json['date'],
      month:json['month']
    );
  }
}
