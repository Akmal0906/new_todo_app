import 'package:bloc/bloc.dart';
import 'package:todo_app/presentation/blocs/cubits/counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(const CounterInitialState(isCorrect: false));



  void increment() {
    if(state is CounterInitialState){
      emit(ChangeState(isCorrect: true));
  }else if(state is ChangeState){
      emit(ChangeState( isCorrect: !state.isCorrect));
    }
    }

}

