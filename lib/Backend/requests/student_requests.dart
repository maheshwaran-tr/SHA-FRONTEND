import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sha/Backend/url_config/urls.dart';

import '../models/student_model.dart';

class StudentRequest {
  static Future<List<Student>> fetchStudents() async {
    final response = await http.get(Uri.parse(Urls.studentUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Student> students =
          data.map((item) => Student.fromJson(item)).toList();
      return students;
    } else {
      throw Exception('Failed to load students');
    }
  }
}
