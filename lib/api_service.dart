import 'dart:convert';
import 'package:http/http.dart' as http;

final String baseUrl = 'https://responsi1b.dalhaqq.xyz/api/assignments';

Future<List<Map<String, dynamic>>> getAllAssignments() async {
  final response = await http.get(Uri.parse(baseUrl));

  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    List<dynamic> assignments = data['result'];
    return List<Map<String, dynamic>>.from(assignments);
  } else {
    throw Exception('Failed to load assignments');
  }
}

Future<Map<String, dynamic>> getAssignmentById(int id) async {
  final response = await http.get(Uri.parse('$baseUrl/$id'));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load assignment');
  }
}

Future<Map<String, dynamic>> createNewAssignment(
    Map<String, dynamic> assignmentData) async {
  final response = await http.post(
    Uri.parse(baseUrl),
    headers: {'Content-Type': 'application/json'},
    body: json.encode(assignmentData),
  );

  if (response.statusCode == 201) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to create assignment');
  }
}

Future<Map<String, dynamic>> updateAssignment(
    int id, Map<String, dynamic> assignmentData) async {
  final response = await http.post(
    Uri.parse('$baseUrl/$id/update'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode(assignmentData),
  );

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to update assignment');
  }
}

Future<void> deleteAssignment(int id) async {
  final response = await http.post(Uri.parse('$baseUrl/$id/delete'));

  if (response.statusCode != 200) {
    throw Exception('Failed to delete assignment');
  }
}
