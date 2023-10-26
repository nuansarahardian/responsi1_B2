import 'package:flutter/material.dart';
import 'package:responsi1/api_service.dart';
import 'package:responsi1/assignment_list_screen.dart';

class CreateAssignmentScreen extends StatefulWidget {
  @override
  _CreateAssignmentScreenState createState() => _CreateAssignmentScreenState();
}

class _CreateAssignmentScreenState extends State<CreateAssignmentScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController deadlineController = TextEditingController();

  void _createAssignment() {
    Map<String, dynamic> newAssignment = {
      "title": titleController.text,
      "description": descriptionController.text,
      "deadline": deadlineController.text,
    };

    createNewAssignment(newAssignment).then((response) {
      // Setelah selesai membuat
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AssignmentListScreen()),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Assignment created successfully"),
          backgroundColor: Colors.green,
        ),
      );

      // Clear the text fields after successful creation
      titleController.clear();
      descriptionController.clear();
      deadlineController.clear();
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to create assignment"),
          backgroundColor: Colors.red,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Assignment - Nuansa'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: deadlineController,
              decoration: InputDecoration(labelText: 'Deadline'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _createAssignment,
              child: Text('Create'),
            ),
          ],
        ),
      ),
    );
  }
}
