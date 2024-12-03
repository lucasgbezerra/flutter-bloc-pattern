import 'package:bloc_pattern/blocs/task_bloc.dart';
import 'package:bloc_pattern/blocs/task_event.dart';
import 'package:bloc_pattern/blocs/task_state.dart';
import 'package:bloc_pattern/data/models/taskModel.dart';
import 'package:bloc_pattern/data/repositories/task_repository.dart';
import 'package:bloc_pattern/presentation/widgets/item.dart';
import 'package:flutter/material.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});


  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  late final TaskBloc _taskBloc = TaskBloc();
  
  @override
  void initState() {
    super.initState();
    _taskBloc.taskSink.add(GetTask());
  }

  @override
  void dispose() {
    _taskBloc.taskSink.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Bloc Pattern"),
          backgroundColor:  Colors.blue
        ),
        body: StreamBuilder(stream: _taskBloc.taskStream, builder: (context, state) {
          if (state.data is TaskLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }else if (state.data is TaskLoadedState) {
            final list = state.data?.tasks ?? [];
            return ListView(
              children: list.map((task) => Item(task: task, deleteFunc: (){
                _taskBloc.taskSink.add(DeleteTask(task: task));
                print("Remover");
                },)).toList(),
            );
          }else {
            return Container();
          }
        }),
          floatingActionButton: FloatingActionButton(onPressed:() {
            print("Adicionando nova tarefa");
            _taskBloc.taskSink.add(PostTask(task: TaskModel(title: "titulo novo", description: "Descricao")));
          }, child: Icon(Icons.add),
          backgroundColor: Colors.blue,),
        );

  }

  
}