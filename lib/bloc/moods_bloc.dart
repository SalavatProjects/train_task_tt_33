import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flagsmith/flagsmith.dart';
import 'package:meta/meta.dart';
import 'package:train_task_tt_33/bloc/mood_state.dart';
import 'package:train_task_tt_33/bloc/trigger_state.dart';
import 'package:train_task_tt_33/storages/isar.dart';
import 'package:train_task_tt_33/storages/models/mood.dart';

part 'moods_state.dart';

class MoodsBloc extends Cubit<MoodsState> {
  MoodsBloc() : super(const MoodsState());

  Future<void> getMoods() async {
    final moods = await AppIsarDatabase.getMoods();
    print(moods);
    emit(
      state.copyWith(
        moodType: null,
        moods: moods.map((e) => MoodState.fromIsarModel(e)).toList(),
      ),
    );
  }

  Future<void> addMood(MoodState mood) async {
    await AppIsarDatabase.addMood(mood.toIsarModel());
    await getMoods();
  }

  Future<void> updateMood(int id, MoodState mood) async {
    await AppIsarDatabase.updateMood(id, mood.toIsarModel());
    await getMoods();
  }

  Future<void> getTriggers() async {
    final triggers = await AppIsarDatabase.getTriggers();
    emit(state.copyWith(
      triggers: triggers.map((e) => TriggerState.fromIsarModel(e)).toList()
    ));
  }

  Future<void> addTrigger(TriggerState trigger) async {
    await AppIsarDatabase.addTrigger(trigger.toIsarModel());
    await getTriggers();
  }

  void updatePage(int index) {
    emit(state.copyWith(page: index));
  }

  void updateMoodType(int index) {
    emit(state.copyWith(moodType: index));
  }

  void updateDate(DateTime value) {
    emit(state.copyWith(date: value));
  }
}
