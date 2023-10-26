import 'package:flutter/material.dart';
import 'package:responsi1/api_service.dart';
import 'package:responsi1/assignment_detail_screen.dart';
import 'package:responsi1/create_assignment_screen.dart';

class AssignmentListScreen extends StatefulWidget {
  @override
  _AssignmentListScreenState createState() => _AssignmentListScreenState();
}

class _AssignmentListScreenState extends State<AssignmentListScreen> {
  late Future<List<Map<String, dynamic>>> assignments;

  @override
  void initState() {
    super.initState();
    assignments = getAllAssignments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assignment List - Nuansa'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateAssignmentScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: assignments,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading assignments'));
          } else {
            List<Map<String, dynamic>> assignments = snapshot.data!;
            return ListView.builder(
              itemCount: assignments.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(assignments[index]['title']),
                  subtitle: Text(assignments[index]['description']),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AssignmentDetailScreen(
                          assignment: assignments[index],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
