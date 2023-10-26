import 'package:flutter/material.dart';
import 'package:responsi1/api_service.dart';

class EditAssignmentScreen extends StatefulWidget {
  final Map<String, dynamic> assignment;

  EditAssignmentScreen({required this.assignment});

  @override
  _EditAssignmentScreenState createState() => _EditAssignmentScreenState();
}

class _EditAssignmentScreenState extends State<EditAssignmentScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController deadlineController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadAssignmentData();
  }

  void _loadAssignmentData() {
    setState(() {
      titleController.text = widget.assignment['title'];
      descriptionController.text = widget.assignment['description'];
      deadlineController.text = widget.assignment['deadline'];
    });
  }

  void _updateAssignment() {
    Map<String, dynamic> updatedAssignment = {
      "title": titleController.text,
      "description": descriptionController.text,
      "deadline": deadlineController.text,
    };

    updateAssignment(widget.assignment['id'], updatedAssignment)
        .then((response) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Assignment updated successfully"),
          backgroundColor: Colors.green,
        ),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to update assignment"),
          backgroundColor: Colors.red,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Assignment - Nuansa'),
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
              onPressed: _updateAssignment,
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
