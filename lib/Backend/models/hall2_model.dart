import 'package:sha/Backend/models/seat_model.dart';

class Hall2 {
  final int id;
  final String hallNumber;
  final int blockId;
  final int capacity;
  final int rows;
  final int columns;
  final int seatPerBench;
  final int extraSeats;
  final List<List<String>> hallMatrix;

  Hall2({
    required this.id,
    required this.hallNumber,
    required this.blockId,
    required this.capacity,
    required this.rows,
    required this.columns,
    required this.seatPerBench,
    required this.extraSeats,
    required this.hallMatrix,
  });

  factory Hall2.fromJson(Map<String, dynamic> json) {
    return Hall2(
      id: json['id'],
      hallNumber: json['hallNumber'],
      blockId: json['blockId'],
      capacity: json['capacity'],
      rows: json['rows'],
      columns: json['columns'],
      seatPerBench: json['seatPerBench'],
      extraSeats: json['extraSeats'],
      hallMatrix: List<List<String>>.from(json['hallMatrix'].map((row) => List<String>.from(row.map((seat) => seat['student'] != null ? seat['student']['department'] : '')))),
    );
  }
}