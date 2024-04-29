import 'package:flutter/material.dart';

import 'Backend/models/student_model.dart';
import 'Backend/requests/student_requests.dart';

class StudentListScreen extends StatefulWidget {
  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student List'),
      ),
      body: FutureBuilder<List<Student>>(
        future: StudentRequest.fetchStudents(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Student> students = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search by name or register number',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    // Implement search logic
                  },
                ),
                SizedBox(height: 20.0),
                DropdownButtonFormField<String>(
                  items: ['All', 'CSE', 'CSD', 'AIDS', 'MECH', 'AGRI'].map((dept) {
                    return DropdownMenuItem(
                      value: dept,
                      child: Text(dept),
                    );
                  }).toList(),
                  onChanged: (value) {
                    // Implement filter by department logic
                  },
                  decoration: InputDecoration(labelText: 'Filter by Department'),
                ),
                SizedBox(height: 20.0),
                Expanded(
                  child: ListView.builder(
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      final student = students[index];
                      return ListTile(
                        title: Text(student.name),
                        subtitle: Text('Reg. No: ${student.registerNumber} - Dept: ${student.department}'),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}