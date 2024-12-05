import 'package:bloc_pattern/blocs/task_bloc.dart';
import 'package:bloc_pattern/blocs/task_event.dart';
import 'package:bloc_pattern/blocs/task_state.dart';
import 'package:bloc_pattern/data/models/taskModel.dart';
import 'package:bloc_pattern/data/repositories/task_repository.dart';
import 'package:bloc_pattern/view/widgets/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    _taskBloc.add(GetTask());
  }

  @override
  void dispose() {
    _taskBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Bloc Pattern"),
          backgroundColor:  Colors.blue
        ),
        body: BlocBuilder(bloc: _taskBloc, builder: (context, state) {
          if (state is TaskLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }else if (state is TaskLoadedState) {
            final list = state?.tasks ?? [];
            return ListView(
              children:
              list.map((task) => Item(task: task, deleteFunc: (){
                _taskBloc.add(DeleteTask(task: task));
                print("Remover");
                },)).toList(),
            );
          }else {
            return Container();
          }
        }),
          floatingActionButton: FloatingActionButton(onPressed:() {
            print("Adicionando nova tarefa");
            _taskBloc.add(PostTask(task: TaskModel(title: "NOVO", description: "Descricao")));
          }, child: Icon(Icons.add),
          backgroundColor: Colors.blue,),
        );

  }

  
}