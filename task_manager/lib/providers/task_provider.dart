import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/task_service.dart';

/// Possible filter states for the task list.
enum TaskFilter { all, completed, pending }

class TaskProvider extends ChangeNotifier {
  final TaskService _taskService = TaskService();

  List<TaskModel> _allTasks = [];
  List<TaskModel> _filteredTasks = [];
  TaskFilter _currentFilter = TaskFilter.all;
  bool _isLoading = false;
  String? _errorMessage;

  // ── Getters ────────────────────────────────────────────
  List<TaskModel> get allTasks => _allTasks;
  List<TaskModel> get tasks => _filteredTasks;
  TaskFilter get currentFilter => _currentFilter;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // ── Fetch ──────────────────────────────────────────────
  Future<void> fetchTasks() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _allTasks = await _taskService.fetchTasks();
      _applyFilter();
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  // ── Filter ─────────────────────────────────────────────
  void setFilter(TaskFilter filter) {
    _currentFilter = filter;
    _applyFilter();
    notifyListeners();
  }

  // ── Toggle Task ────────────────────────────────────────
  void toggleTask(int taskId) {
    final index = _allTasks.indexWhere((t) => t.id == taskId);
    if (index == -1) return;
    _allTasks[index] = _allTasks[index].copyWith(
      completed: !_allTasks[index].completed,
    );
    _applyFilter();
    notifyListeners();
  }

  // ── Add Task ───────────────────────────────────────────
  void addTask(String title, {String? description, DateTime? deadline}) {
    final newTask = TaskModel(
      userId: 1,
      id: _allTasks.length + 1,
      title: title,
      completed: false,
      description: description,
      deadline: deadline,
    );
    _allTasks.insert(0, newTask);
    _applyFilter();
    notifyListeners();
  }

  void _applyFilter() {
    switch (_currentFilter) {
      case TaskFilter.all:
        _filteredTasks = List.from(_allTasks);
        break;
      case TaskFilter.completed:
        _filteredTasks = _allTasks.where((t) => t.completed).toList();
        break;
      case TaskFilter.pending:
        _filteredTasks = _allTasks.where((t) => !t.completed).toList();
        break;
    }
  }
}
