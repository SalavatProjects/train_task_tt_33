import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'mood_state.dart';

class MoodBloc extends Cubit<MoodState> {
  MoodBloc({MoodState? mood}) : super(mood ?? const MoodState());

  void updateType(int value) {
    emit(state.copyWith(type: value));
  }

  void updateTriggerId(int value) {
    emit(state.copyWith(triggerId: value));
  }

  void addReason(String value) {
    emit(state.copyWith(reasons: [...state.reasons, value]));
  }

  void deleteReason(int index) {
    final copy = state.reasons.toList();
    copy.removeAt(index);
    emit(state.copyWith(reasons: copy));
  }

  /*void updateReasons(List<String> value) {
    emit(state.copyWith(reasons: List.from(value)));
  }*/

  void updateComment(String value) {
    emit(state.copyWith(comment: value));
  }

  void updateDate(DateTime value) {
    emit(state.copyWith(date: value));
  }
}
