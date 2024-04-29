// To parse this JSON data, do
//
//     final exam = examFromJson(jsonString);


import 'dart:convert';

Exam examFromJson(String str) => Exam.fromJson(json.decode(str));

String examToJson(Exam data) => json.encode(data.toJson());

class Exam {
  final int id;
  final String name;
  final int year;
  final String session;
  final DateTime date;

  Exam({
    required this.id,
    required this.name,
    required this.year,
    required this.session,
    required this.date,
  });

  factory Exam.fromJson(Map<String, dynamic> json) => Exam(
    id: json["id"],
    name: json["name"],
    year: json["year"],
    session: json["session"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "year": year,
    "session": session,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
  };
}
