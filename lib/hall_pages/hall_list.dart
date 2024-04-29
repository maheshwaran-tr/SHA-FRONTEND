import 'package:flutter/material.dart';
import 'package:sha/Backend/requests/hall_requests.dart';

import '../Backend/models/hall_model.dart';

class HallList extends StatefulWidget {
  const HallList({Key? key}) : super(key: key);

  @override
  State<HallList> createState() => _HallListState();
}

class _HallListState extends State<HallList> {
  Future<List<Hall>>? halls;

  @override
  void initState() {
    super.initState();
    halls = HallRequests.getHalls();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halls List'),
      ),
      body: FutureBuilder<List<Hall>>(
        future: halls,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final halls = snapshot.data!;
            return ListView.builder(
              itemCount: halls.length,
              itemBuilder: (context, index) {
                final hall = halls[index];
                return HallListItem(
                    hall: hall,
                    onEdit: () => editHall(hall),
                    onDelete: () => deleteHall(hall.id));
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  void editHall(Hall hall) {
    // Implement navigation to edit screen, passing the hall object
  }

  void deleteHall(int hallId) async {
    // Implement logic to delete hall from API and update UI
  }
}

class HallListItem extends StatelessWidget {
  final Hall hall;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const HallListItem({
    Key? key,
    required this.hall,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  // Customize styling here based on "isStylish" flag or other criteria
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(hall.hallNumber),
        subtitle: Text('Capacity: ${hall.capacity}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDelete,
              color: Colors.red, // Emphasize delete button
            ),
          ],
        ),
      ),
    );
  }
}
