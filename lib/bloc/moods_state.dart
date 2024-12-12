part of 'moods_bloc.dart';

class MoodsState extends Equatable{
  const MoodsState({
      this.moods = const [],
      this.triggers = const [],
      this.page = 0,
      this.moodType,
      this.date,
  });

  final List<MoodState> moods;
  final List<TriggerState> triggers;
  final int page;
  final int? moodType;
  final DateTime? date;

  @override
  // TODO: implement props
  List<Object?> get props => [moods, triggers, page, moodType, date];

  MoodsState copyWith({
    List<MoodState>? moods,
    List<TriggerState>? triggers,
    int? page,
    int? moodType,
    DateTime? date,
  }) {
    return MoodsState(
      moods: moods ?? this.moods,
      triggers: triggers ?? this.triggers,
      page: page ?? this.page,
      moodType: moodType ?? this.moodType,
      date: date ?? this.date
    );
  }

}
