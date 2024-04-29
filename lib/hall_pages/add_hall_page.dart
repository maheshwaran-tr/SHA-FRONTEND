import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sha/Backend/requests/hall_requests.dart';

import '../Backend/models/hall_model.dart';

class AddHallScreen extends StatefulWidget {
  @override
  _AddHallScreenState createState() => _AddHallScreenState();
}

class _AddHallScreenState extends State<AddHallScreen> {
  TextEditingController hallNumberController = TextEditingController();
  TextEditingController rowsController = TextEditingController();
  TextEditingController columnsController = TextEditingController();
  TextEditingController seatPerBenchController = TextEditingController();
  TextEditingController extraSeatsController = TextEditingController();
  String? _selectedBlock;
  bool isAvailable = true;
  int calculatedCapacity = 0;

  @override
  void initState() {
    super.initState();
    // Pre-calculate capacity initially (optional, can be calculated on demand)
    _calculateCapacity();
  }

  void _calculateCapacity() {
    try {
      int rows = int.parse(rowsController.text);
      int columns = int.parse(columnsController.text);
      int seatPerBench = int.parse(seatPerBenchController.text);
      int extraSeats = int.parse(extraSeatsController.text);
      calculatedCapacity = rows * columns * seatPerBench + extraSeats;
      setState(() {}); // Update UI with calculated capacity
    } catch (e) {
      print('Error calculating capacity: $e');
    }
  }

  Future<void> addHall() async {
    try {
      if (_selectedBlock != null) {
        int blockId = 0;
        if (_selectedBlock == 'CSE BLOCK') {
          blockId = 1;
        } else if (_selectedBlock == 'EEE BLOCK') {
          blockId = 2;
        } else if (_selectedBlock == 'MECH BLOCK') {
          blockId = 3;
        }

        Hall newHall = Hall(
          id: 0,
          // Assuming 0 for a new hall, adjust as needed
          hallNumber: hallNumberController.text,
          blockId: blockId,
          capacity: calculatedCapacity,
          // Use calculated capacity
          rows: int.tryParse(rowsController.text) ?? 0,
          columns: int.tryParse(columnsController.text) ?? 0,
          seatPerBench: int.tryParse(seatPerBenchController.text) ?? 0,
          extraSeats: int.tryParse(extraSeatsController.text) ?? 0,
        );

        await HallRequests.createHall(newHall);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Hall added successfully'),
          duration: Duration(seconds: 2),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please select a block'),
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      print('Error adding hall: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to add hall'),
        duration: Duration(seconds: 2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Hall'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Card(
          elevation: 5.0,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Add New Hall',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: hallNumberController,
                  decoration: InputDecoration(labelText: 'Hall Number'),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  controller: rowsController,
                  decoration: InputDecoration(labelText: 'Rows'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) =>
                      _calculateCapacity(), // Recalculate on change
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  controller: columnsController,
                  decoration: InputDecoration(labelText: 'Columns'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) =>
                      _calculateCapacity(), // Recalculate on change
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  controller: seatPerBenchController,
                  decoration: InputDecoration(labelText: 'Seat per Bench'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) =>
                      _calculateCapacity(), // Recalculate on change
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  controller: extraSeatsController,
                  decoration: InputDecoration(labelText: 'Extra Seats'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) =>
                      _calculateCapacity(), // Recalculate on change
                ),
                SizedBox(height: 10.0),
                DropdownButtonFormField<String>(
                  value: _selectedBlock,
                  decoration: InputDecoration(labelText: 'Block Name'),
                  onChanged: (value) {
                    setState(() {
                      _selectedBlock = value;
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      value: '-',
                      child: Text('NONE'),
                    ),
                    DropdownMenuItem(
                      value: 'CSE BLOCK',
                      child: Text('CSE BLOCK'),
                    ),
                    DropdownMenuItem(
                      value: 'EEE BLOCK',
                      child: Text('EEE BLOCK'),
                    ),
                    DropdownMenuItem(
                      value: 'MECH BLOCK',
                      child: Text('MECH BLOCK'),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  children: [
                    Text('Availability: '),
                    Switch(
                      value: isAvailable,
                      onChanged: (value) {
                        setState(() {
                          isAvailable = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Text(
                  'Calculated Capacity: $calculatedCapacity',
                  // Display calculated capacity
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: addHall,
                  child: Text('Add Hall'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
