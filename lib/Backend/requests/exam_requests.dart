import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sha/Backend/url_config/urls.dart';

import '../models/exam_model.dart';

class ExamRequests {
  static Future<void> createExamHall(Exam exam) async {

    final headers = {'Content-Type': 'application/json'};
    final payload = json.encode(exam.toJson());

    final response = await http.post(Uri.parse(Urls.examUrl),
        headers: headers, body: payload);

    if (response.statusCode == 200) {
      // Exam hall created successfully
      print('Exam hall created successfully!');
    } else {
      // Error handling
      print('Failed to create exam hall. Error: ${response.reasonPhrase}');
    }
  }

  static Future<List<Exam>> getExams() async {
    final response = await http.get(Uri.parse(Urls.examUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((json) => Exam.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load halls');
    }
  }
}
