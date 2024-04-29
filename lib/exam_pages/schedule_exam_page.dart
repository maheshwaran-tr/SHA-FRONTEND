import 'package:flutter/material.dart';
import 'package:sha/Backend/requests/exam_requests.dart';

import '../Backend/models/exam_model.dart';

class ScheduleExamScreen extends StatefulWidget {
  @override
  _ScheduleExamScreenState createState() => _ScheduleExamScreenState();
}

class _ScheduleExamScreenState extends State<ScheduleExamScreen> {
  String? _selectedYear;
  DateTime? _selectedDate;
  String? _selectedSession;
  TextEditingController _examNameController = TextEditingController();

  List<String> years = ['I', 'II', 'III', 'IV'];
  List<String> sessions = ['FN', 'AN'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule Exam'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Card(
            elevation: 5.0,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Schedule New Exam',
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: _examNameController,
                    decoration: InputDecoration(labelText: 'Exam Name'),
                  ),
                  SizedBox(height: 10.0),
                  DropdownButtonFormField<String>(
                    value: _selectedYear,
                    onChanged: (value) {
                      setState(() {
                        _selectedYear = value;
                      });
                    },
                    items: years.map((year) {
                      return DropdownMenuItem(
                        value: year,
                        child: Text(year),
                      );
                    }).toList(),
                    decoration: InputDecoration(labelText: 'Year'),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Date'),
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null && picked != _selectedDate) {
                        setState(() {
                          _selectedDate = picked;
                        });
                      }
                    },
                    readOnly: true,
                    controller: TextEditingController(
                      text: _selectedDate != null ? "${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}" : '',
                    ),
                  ),
                  SizedBox(height: 10.0),
                  DropdownButtonFormField<String>(
                    value: _selectedSession,
                    onChanged: (value) {
                      setState(() {
                        _selectedSession = value;
                      });
                    },
                    items: sessions.map((session) {
                      return DropdownMenuItem(
                        value: session,
                        child: Text(session),
                      );
                    }).toList(),
                    decoration: InputDecoration(labelText: 'Session'),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      try {
                        if (_selectedYear != null &&
                            _selectedDate != null &&
                            _selectedSession != null &&
                            _examNameController.text.isNotEmpty) {
                          // Convert year to numeric value
                          int yearValue = years.indexOf(_selectedYear!) + 1;
                          // Create exam hall using HTTP POST request
                          ExamRequests.createExamHall(
                            Exam(
                              id: 0,
                              name: _examNameController.text,
                              year: yearValue,
                              date: _selectedDate!,
                              session: _selectedSession!,
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Exam Scheduled successfully'),
                            duration: Duration(seconds: 2),
                          ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Please select all options'),
                            duration: Duration(seconds: 2),
                          ));
                        }
                      }catch(e){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Failed to Schedule Exam'),
                          duration: Duration(seconds: 2),
                        ));
                      }
                    },
                    child: Text('Schedule Exam'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
