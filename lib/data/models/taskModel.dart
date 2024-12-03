class TaskModel {
  int? id;
  String title;
  String description;
  bool? isCompleted;

  TaskModel({this.id, required this.title, required this.description, this.isCompleted=false});

}