import 'package:flutter/material.dart';
import 'package:responsi1/api_service.dart';
import 'package:responsi1/edit_assignment_screen.dart';
import 'package:responsi1/assignment_list_screen.dart';

class AssignmentDetailScreen extends StatelessWidget {
  final Map<String, dynamic> assignment;

  AssignmentDetailScreen({required this.assignment});

  void _deleteAssignment(BuildContext context) {
    int id = assignment['id'];

    deleteAssignment(id).then((_) {
      // Setelah selesai mengedit atau menghapus
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AssignmentListScreen()),
      );

      Navigator.pop(context,
          true); // Kembali ke halaman sebelumnya dengan memberi tanda bahwa tugas telah dihapus.
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to delete assignment"),
          backgroundColor: Colors.red,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assignment Detail - Nuansa'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title: ${assignment['title']}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Description: ${assignment['description']}'),
            SizedBox(height: 10),
            Text('Deadline: ${assignment['deadline']}'),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditAssignmentScreen(
                          assignment: assignment,
                        ),
                      ),
                    );
                  },
                  child: Text('Edit Assignment'),
                ),
                ElevatedButton(
                  onPressed: () => _deleteAssignment(context),
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  child: Text('Delete Assignment'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
