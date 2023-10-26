import 'package:flutter/material.dart';
import 'package:responsi1/assignment_list_screen.dart';
import 'package:responsi1/create_assignment_screen.dart';
import 'package:responsi1/edit_assignment_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Management App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AssignmentListScreen(),
    );
  }
}
