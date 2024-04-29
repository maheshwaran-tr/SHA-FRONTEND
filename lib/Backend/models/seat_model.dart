import 'package:sha/Backend/models/student_model.dart';

class Seat {
  final String? seatName;
  final Student student;

  Seat({this.seatName, required this.student});

  factory Seat.fromJson(Map<String, dynamic> json) {
    return Seat(
      seatName: json['seatName'],
      student: json['student'],
    );
  }
}