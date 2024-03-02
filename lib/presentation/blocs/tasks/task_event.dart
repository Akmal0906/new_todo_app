part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();
}

final class AddTaskEvent extends TaskEvent{
  final String startTime;
  final String endTime;
  final String clockTime;
  final String task;
  const AddTaskEvent({required this.startTime,required this.endTime,required this.clockTime,required this.task});

  @override
  List<Object?> get props => [startTime,endTime,clockTime,task];
}
final class TaskInitialEvent extends TaskEvent{
  @override
  List<Object?> get props => [];
}

