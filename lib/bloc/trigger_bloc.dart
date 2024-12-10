import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:train_task_tt_33/storages/isar.dart';
import 'trigger_state.dart';

class TriggerBloc extends Cubit<TriggerState> {
  TriggerBloc({TriggerState? trigger}) : super(trigger ?? const TriggerState());

  void updateName(String value) {
    emit(state.copyWith(name: value));
  }

  void updateSubject(List<String> value) {
    emit(state.copyWith(subjects: value));
  }

  /*void addSubjects(List<String> value) {
    List<String> updatedSubjects = [];
    if (state.subjects == null) {
      updatedSubjects.addAll(value);
    } else {
      updatedSubjects = List.from(state.subjects!)..addAll(value);
    }
    emit(state.copyWith(subjects: updatedSubjects));
  }

  void deleteSubject(int index) {
    List<String> updatedSubjects = [];
    if (state.subjects != null) {
      state.subjects!.removeAt(index);
      updatedSubjects = state.subjects!;
      emit(state.copyWith(subjects: updatedSubjects));
    }
  }*/

  void updateComment(String value) {
    emit(state.copyWith(comment: value));
  }
}
