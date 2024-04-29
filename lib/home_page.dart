import 'package:flutter/material.dart';


class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Seat Master'),
          automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Navigate to profile screen
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, Admin!',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Text(
              'What would you like to do today?',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 30.0),
            _buildOptionItem(
              context,
              'Arrange Seats',
              Icons.event_seat,
                  () {
                // Navigate to add hall screen
                Navigator.pushNamed(context, '/allotment');
              },
            ),
            SizedBox(height: 10.0),
            _buildOptionItem(
              context,
              'Add Hall',
              Icons.location_on,
                  () {
                // Navigate to add hall screen
                    Navigator.pushNamed(context, '/addHall');
              },
            ),
            SizedBox(height: 10.0),
            _buildOptionItem(
              context,
              'All Halls',
              Icons.line_weight_sharp,
                  () {
                // Navigate to add hall screen
                Navigator.pushNamed(context, '/hallList');
              },
            ),
            SizedBox(height: 10.0),
            _buildOptionItem(
              context,
              'Schedule Exams',
              Icons.calendar_today,
                  () {
                // Navigate to schedule exams screen
                    Navigator.pushNamed(context, '/scheduleExam');
              },
            ),
            SizedBox(height: 10.0),
            _buildOptionItem(
              context,
              'Exams List',
              Icons.calendar_today,
                  () {
                // Navigate to schedule exams screen
                    Navigator.pushNamed(context, '/examList');
              },
            ),
            SizedBox(height: 10.0),
            _buildOptionItem(
              context,
              'Student List',
              Icons.people,
                  () {
                // Navigate to student list screen
                    Navigator.pushNamed(context, '/studentList');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionItem(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: Colors.white),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.white),
          ],
        ),
      ),
    );
  }

}