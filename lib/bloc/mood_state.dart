import 'package:equatable/equatable.dart';
import 'package:train_task_tt_33/storages/models/mood.dart';


class MoodState extends Equatable{
  const MoodState({
    this.id,
    this.type,
    this.triggerId,
    this.reasons,
    this.date
  });

  final int? id;
  final int? type;
  final int? triggerId;
  final List<String>? reasons;
  final DateTime? date;

  factory MoodState.fromIsarModel(Mood mood) {
    return MoodState(
        id: mood.id,
        type: mood.type,
        triggerId: mood.triggerId,
        reasons: mood.reasons,
        date: mood.date);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, type, triggerId, reasons, date];

  MoodState copyWith({
    int? id,
    int? type,
    int? triggerId,
    List<String>? reasons,
    DateTime? date
  }) {
   return MoodState(
       id: id ?? this.id,
       type: type ?? this.type,
       triggerId: triggerId ?? this.triggerId,
       reasons: reasons ?? this.reasons,
       date: date ?? this.date
   );
  }

  Mood toIsarModel() {
    return Mood()
        ..type = type
        ..triggerId = triggerId
        ..reasons = reasons
        ..date = date;
  }
}

