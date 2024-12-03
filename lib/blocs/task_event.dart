import 'package:bloc_pattern/data/models/taskModel.dart';

abstract class TaskEvent {

}

class GetTask extends TaskEvent {

}

class PostTask extends TaskEvent {
  final TaskModel task;

  PostTask({required this.task});

}
class DeleteTask extends TaskEvent {
  final TaskModel task;

  DeleteTask({required this.task});
}
