import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/task_model.dart';

class TaskService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com/todos';

  /// Fetches the list of tasks from the API.
  /// Throws an [Exception] on failure.
  Future<List<TaskModel>> fetchTasks() async {
    final response = await http.get(
      Uri.parse(_baseUrl),
      headers: {'User-Agent': 'PlanitApp/1.0', 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => TaskModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tasks (${response.statusCode})');
    }
  }
}
