import 'dart:convert';

import 'package:flutter/material.dart';

import '../Backend/models/block_model.dart';
import '../Backend/models/hall_model.dart';
import 'package:http/http.dart' as http;

import '../allotment.dart';


class SelectHallPage extends StatefulWidget {
  @override
  _SelectHallPageState createState() => _SelectHallPageState();
}

class _SelectHallPageState extends State<SelectHallPage> {
  List<int> _selectedYears = [];
  List<Block> _blocks = [];
  List<Hall> _halls = [];
  List<Hall> _selectedHalls = [];



  @override
  void initState() {
    super.initState();
    fetchBlocksAndHalls();
  }

  Future<void> fetchBlocksAndHalls() async {
    // Fetch blocks
    final responseBlocks = await http.get(Uri.parse('http://10.0.2.2:7070/block'));
    if (responseBlocks.statusCode == 200) {
      setState(() {
        _blocks = (jsonDecode(responseBlocks.body) as List)
            .map((blockJson) => Block.fromJson(blockJson))
            .toList();
      });
    } else {
      throw Exception('Failed to load blocks');
    }

    // Fetch halls
    final responseHalls = await http.get(Uri.parse('http://10.0.2.2:7070/hall'));
    if (responseHalls.statusCode == 200) {
      setState(() {
        _halls = (jsonDecode(responseHalls.body) as List)
            .map((hallJson) => Hall.fromJson(hallJson))
            .toList();
      });
    } else {
      throw Exception('Failed to load halls');
    }
  }

  void _updateSelectedHalls(List<Hall> selectedHalls) {
    setState(() {
      _selectedHalls = selectedHalls;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Halls'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select the year:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            CheckboxGroup(
              years: ['1', '2', '3', '4'],
              selectedYears: _selectedYears,
              onChanged: (selectedYears) {
                setState(() {
                  _selectedYears = selectedYears;
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'Select the halls:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            SizedBox(height: 10),
            Flexible( // Wrap the ListView.builder in a Flexible widget
              child: ListView.builder(
                itemCount: _blocks.length,
                itemBuilder: (context, index) {
                  return BlockWithHalls(
                    block: _blocks[index],
                    halls: _halls.where((hall) => hall.blockId == _blocks[index].id).toList(),
                    onHallsSelected: _updateSelectedHalls,
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Perform action when Generate button is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HallVisualizationScreen(),
                    ),
                  );
                },
                child: Text('Generate'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CheckboxGroup extends StatelessWidget {
  final List<String> years;
  final List<int> selectedYears;
  final ValueChanged<List<int>> onChanged;

  CheckboxGroup({
    required this.years,
    required this.selectedYears,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: years
          .map(
            (year) => Row(
          children: [
            Checkbox(
              value: selectedYears.contains(int.parse(year)),
              onChanged: (value) {
                List<int> updatedSelectedYears = List.from(selectedYears);
                if (value != null && value) {
                  updatedSelectedYears.add(int.parse(year));
                } else {
                  updatedSelectedYears.remove(int.parse(year));
                }
                onChanged(updatedSelectedYears);
              },
            ),
            Text(year),
          ],
        ),
      )
          .toList(),
    );
  }
}


class BlockWithHalls extends StatefulWidget {
  final Block block;
  final List<Hall> halls;
  final Function(List<Hall>) onHallsSelected;

  BlockWithHalls({required this.block, required this.halls, required this.onHallsSelected});

  @override
  _BlockWithHallsState createState() => _BlockWithHallsState();
}

class _BlockWithHallsState extends State<BlockWithHalls> {
  List<Hall> _selectedHalls = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Checkbox(value: false, onChanged: null),
            Text(widget.block.name, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        Column(
          children: widget.halls
              .map(
                (hall) => CheckboxListTile(
              title: Text(hall.hallNumber),
              value: _selectedHalls.contains(hall),
              onChanged: (value) {
                setState(() {
                  if (value != null && value) {
                    _selectedHalls.add(hall);
                  } else {
                    _selectedHalls.remove(hall);
                  }
                  widget.onHallsSelected(_selectedHalls);
                });
              },
            ),
          )
              .toList(),
        ),
      ],
    );
  }
}


