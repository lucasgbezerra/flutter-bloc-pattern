import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_pattern/blocs/task_event.dart';
import 'package:bloc_pattern/blocs/task_state.dart';
import 'package:bloc_pattern/data/models/taskModel.dart';
import 'package:bloc_pattern/data/repositories/task_repository.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final _repository = TaskRepository();

  TaskBloc() : super(TaskInitialState()) {
    on(_mapEventToState);
  }
  

  Future<void> _mapEventToState(TaskEvent event, Emitter<TaskState> emit) async {
try {
    // Emitir o estado de carregamento
    emit(TaskLoadingState());

    List<TaskModel> tasks = [];

    if (event is GetTask) {
      tasks = await _repository.getAllTasks();
    } else if (event is PostTask) {
      await _repository.addTask(task: event.task); // Adiciona tarefa
      tasks = await _repository.getAllTasks();     // Busca lista atualizada
    } else if (event is DeleteTask) {
      await _repository.deleteTaskById(task: event.task); // Deleta tarefa
      tasks = await _repository.getAllTasks();            // Busca lista atualizada
    }

    // Emitir o estado de tarefas carregadas
    emit(TaskLoadedState(tasks: tasks));
    
  } catch (error) {
    // Emitir um estado de erro em caso de falha
    emit(TaskErrorState(error: error.toString()));
  }
  }
}