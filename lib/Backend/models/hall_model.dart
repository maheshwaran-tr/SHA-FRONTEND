// To parse this JSON data, do
//
//     final hall = hallFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Hall hallFromJson(String str) => Hall.fromJson(json.decode(str));

String hallToJson(Hall data) => json.encode(data.toJson());

class Hall {
  final int id;
  final String hallNumber;
  final int blockId;
  final int capacity;
  final int rows;
  final int columns;
  final int seatPerBench;
  final int extraSeats;

  Hall({
    required this.id,
    required this.hallNumber,
    required this.blockId,
    required this.capacity,
    required this.rows,
    required this.columns,
    required this.seatPerBench,
    required this.extraSeats,
  });

  factory Hall.fromJson(Map<String, dynamic> json) => Hall(
    id: json["id"],
    hallNumber: json["hallNumber"],
    blockId: json["blockId"],
    capacity: json["capacity"],
    rows: json["rows"],
    columns: json["columns"],
    seatPerBench: json["seatPerBench"],
    extraSeats: json["extraSeats"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "hallNumber": hallNumber,
    "blockId": blockId,
    "capacity": capacity,
    "rows": rows,
    "columns": columns,
    "seatPerBench": seatPerBench,
    "extraSeats": extraSeats,
  };
}
