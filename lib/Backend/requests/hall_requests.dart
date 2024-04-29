import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sha/Backend/url_config/urls.dart';

import '../models/hall2_model.dart';
import '../models/hall_model.dart';


class HallRequests{
  static Future<void> createHall(Hall newHall) async {
    final response = await http.post(
      Uri.parse(Urls.hallUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(newHall.toJson()),
    );

    if (response.statusCode == 201) {
      print('New hall created successfully');
    } else {
      print('Failed to create hall. Status code: ${response.statusCode}');
    }
  }

  static Future<List<Hall>> getHalls() async {
    final response = await http.get(Uri.parse(Urls.hallUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((json) => Hall.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load halls');
    }
  }

  static Future<List<Hall2>> sendSelectedHalls(List<Hall> selectedHalls) async {
    final Uri url = Uri.parse('http://10.0.2.2:7070/arrange'); // Replace with your API endpoint

    // Convert the list of selected halls to JSON format
    List<Map<String, dynamic>> selectedHallsJson = selectedHalls.map((hall) => hall.toJson()).toList();

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(selectedHallsJson),
      );

      if (response.statusCode == 200) {
        // If the request is successful, parse the response JSON and return the list of halls
        List<dynamic> responseData = jsonDecode(response.body);
        List<Hall2> halls = responseData.map((hallJson) => Hall2.fromJson(hallJson)).toList();
        return halls;
      } else {
        // If the request fails, throw an exception with the error message
        throw Exception('Failed to send selected halls: ${response.statusCode}');
      }
    } catch (e) {
      // Catch any errors that occur during the request and throw an exception
      throw Exception('Error sending selected halls: $e');
    }
  }
}