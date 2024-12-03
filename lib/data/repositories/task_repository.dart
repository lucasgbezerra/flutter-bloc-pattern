import 'package:bloc_pattern/data/models/taskModel.dart';

class TaskRepository {
  final List<TaskModel> _tasks = [];

  TaskRepository() {
    _tasks.add(TaskModel(id: 1, title: "Task 1", description: "Description 1"));
    _tasks.add(TaskModel(id: 2, title: "Task 2", description: "Description 2"));
    _tasks.add(TaskModel(id: 3, title: "Task 3", description: "Description 3"));
  }
  Future<List<TaskModel>> getAllTasks() async{
    return Future<List<TaskModel>>.delayed(Duration(seconds: 2), () => _tasks);
  }

  Future<List<TaskModel>> addTask({required TaskModel task}) {
    _tasks.add(task);
    return Future<List<TaskModel>>.delayed(Duration(seconds: 2), () => _tasks);
  }


  Future<List<TaskModel>> deleteTaskById({required TaskModel task}) {
    _tasks.remove(task);
    return Future<List<TaskModel>>.delayed(Duration(seconds: 2), () => _tasks);
  }
}