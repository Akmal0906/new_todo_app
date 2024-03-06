import 'package:equatable/equatable.dart';

 sealed class CounterState extends Equatable{
final bool isCorrect;
const CounterState({required this.isCorrect});

  @override
  List<Object?> get props => [isCorrect];
}
final class CounterInitialState extends CounterState{
    const CounterInitialState({required super.isCorrect});
  @override
  List<Object?> get props => [isCorrect];

}
final class ChangeState extends CounterState{
    ChangeState({ required super.isCorrect});

  @override
  List<Object?> get props => [isCorrect];
}