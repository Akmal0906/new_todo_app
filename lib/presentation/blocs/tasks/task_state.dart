part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();
}

class TaskInitial extends TaskState {
  @override
  List<Object> get props => [];
}

final class AddedSuccessTaskState extends TaskState{
  final String success;
  const AddedSuccessTaskState({required this.success});
  @override
  List<Object> get props => [success];
}
final class TaskLoading extends TaskState{
  @override
  List<Object> get props => [];
}
final class ErrorTaskState extends TaskState{
  final String error;
  const ErrorTaskState({required this.error});
  @override
  List<Object> get props => [error];
}


