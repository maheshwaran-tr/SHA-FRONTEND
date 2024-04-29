// To parse this JSON data, do
//
//     final student = studentFromJson(jsonString);


import 'dart:convert';

Student studentFromJson(String str) => Student.fromJson(json.decode(str));

String studentToJson(Student data) => json.encode(data.toJson());

class Student {
  final int id;
  final String name;
  final int registerNumber;
  final String department;
  final int year;

  Student({
    required this.id,
    required this.name,
    required this.registerNumber,
    required this.department,
    required this.year,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
    id: json["id"],
    name: json["name"],
    registerNumber: json["registerNumber"],
    department: json["department"],
    year: json["year"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "registerNumber": registerNumber,
    "department": department,
    "year": year,
  };
}
