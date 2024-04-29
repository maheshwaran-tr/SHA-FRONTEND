import 'package:flutter/material.dart';
import 'package:sha/Backend/requests/exam_requests.dart';
import 'package:sha/Backend/requests/hall_requests.dart';

import '../Backend/models/exam_model.dart';
import '../Backend/models/hall_model.dart';

class ExamList extends StatefulWidget {
  const ExamList({Key? key}) : super(key: key);

  @override
  State<ExamList> createState() => _ExamListState();
}

class _ExamListState extends State<ExamList> {
  Future<List<Exam>>? exams;

  @override
  void initState() {
    super.initState();
    exams = ExamRequests.getExams();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exam List'),
      ),
      body: FutureBuilder<List<Exam>>(
        future: exams,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final halls = snapshot.data!;
            return ListView.builder(
              itemCount: halls.length,
              itemBuilder: (context, index) {
                final exam = halls[index];
                return ExamListItem(
                    exam: exam,
                    onEdit: () => editExam(exam),
                    onDelete: () => deleteExam(exam.id));
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

  void editExam(Exam exam) {
    // Implement navigation to edit screen, passing the hall object
  }

  void deleteExam(int examId) async {
    // Implement logic to delete hall from API and update UI
  }
}

class ExamListItem extends StatelessWidget {
  final Exam exam;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ExamListItem({
    Key? key,
    required this.exam,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  // Customize styling here based on "isStylish" flag or other criteria
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(exam.name),
        subtitle: Text('Date: ${exam.date.toString().split(" ")[0]} / ${exam.session}'),
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
