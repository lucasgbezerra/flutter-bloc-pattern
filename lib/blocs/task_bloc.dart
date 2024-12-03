import 'dart:async';

import 'package:bloc_pattern/blocs/task_event.dart';
import 'package:bloc_pattern/blocs/task_state.dart';
import 'package:bloc_pattern/data/models/taskModel.dart';
import 'package:bloc_pattern/data/repositories/task_repository.dart';

class TaskBloc {
  final _repository = TaskRepository();

  // Controladores da tarefa
  final StreamController<TaskEvent> _inputTaskController = StreamController<TaskEvent>();
  final StreamController<TaskState> _outputTaskController = StreamController<TaskState>();

  Stream<TaskState> get taskStream => _outputTaskController.stream;
  StreamSink<TaskEvent> get taskSink => _inputTaskController.sink;

  TaskBloc() {
    _inputTaskController.stream.listen(_mapEventToState);
  }
  

  void _mapEventToState(TaskEvent event) {
      List<TaskModel > tasks = [];

    // Sempre que um evento é adicionado ocorre um loading
    _outputTaskController.add(TaskLoadingState());

    if(event is GetTask) {
      _repository.getAllTasks().then((value) {
        tasks = value;
        _outputTaskController.add(TaskLoadedState(tasks: tasks));
      });
    } else if (event is PostTask) {
      _repository.addTask(task: event.task).then((value) {
        _repository.getAllTasks().then((value) {
          tasks = value;
          _outputTaskController.add(TaskLoadedState(tasks: tasks));
        });
      });
    } else if (event is DeleteTask) {
      _repository.deleteTaskById(task: event.task).then((value) {
        tasks = value;
        _outputTaskController.add(TaskLoadedState(tasks: tasks));
      });
    }
  }
}