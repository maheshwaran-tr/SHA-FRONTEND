import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sha/Backend/requests/hall_requests.dart';
import 'package:http/http.dart' as http;

import 'Backend/models/hall2_model.dart';
import 'Backend/models/hall_model.dart';

class HallVisualizationScreen extends StatefulWidget {
  const HallVisualizationScreen({Key? key}) : super(key: key);

  @override
  State<HallVisualizationScreen> createState() => _HallVisualizationScreenState();
}

class _HallVisualizationScreenState extends State<HallVisualizationScreen> {
  List<dynamic>? hallList;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      var response = await http.get(Uri.parse("http://10.0.2.2:7070/arrange"));
      if (response.statusCode == 200) {
        List<dynamic> hallJsonList = json.decode(response.body);
        setState(() {
          hallList = hallJsonList;
        });
      } else {
        throw Exception('Failed to load hall data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error loading hall data: $e');
      // Handle error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hall Visualization'),
      ),
      body: hallList == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: hallList!.length,
        itemBuilder: (context, index) {
          Hall2 hall = Hall2.fromJson(hallList![index]);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                title: Text('Hall - ${hall.hallNumber}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HallDetailsScreen(hall: hall),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class HallDetailsScreen extends StatelessWidget {
  final Hall2 hall;

  HallDetailsScreen({required this.hall});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hall Visualization - ${hall.hallNumber}'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Hall - ${hall.hallNumber}',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0),
              GridView.builder(
                shrinkWrap: true,
                itemCount: hall.rows * hall.columns,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: hall.columns,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemBuilder: (context, index) {
                  int row = index ~/ hall.columns;
                  int col = index % hall.columns;
                  String seatNumber = hall.hallMatrix[row][col];
                  return SeatWidget(
                    seatNumber: seatNumber,
                    color: seatNumber.isNotEmpty ? Colors.blueAccent : Colors.transparent,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your print logic here
          print('Printing hall details');
        },
        child: Icon(Icons.print),
      ),
    );
  }
}

class SeatWidget extends StatelessWidget {
  final String seatNumber;
  final Color color;

  const SeatWidget({Key? key, required this.seatNumber, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          seatNumber,
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
