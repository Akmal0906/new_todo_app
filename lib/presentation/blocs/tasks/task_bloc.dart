import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/network/api.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final FetchData fetchData;
  TaskBloc({required this.fetchData}) : super(TaskInitial()) {
    on<AddTaskEvent>(_addTask);
    on<TaskInitialEvent>((event, emit) => emit(TaskInitial()));
  }


  void _addTask(
      AddTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    final String? string=await fetchData.postToDo(event.startTime,event.endTime,event.clockTime,event.task);

    switch(string){
      case null: emit(const ErrorTaskState(error: 'Something went wrong',));
      break;
      default:emit(AddedSuccessTaskState(success: string));
      break;
    }

  }
}
