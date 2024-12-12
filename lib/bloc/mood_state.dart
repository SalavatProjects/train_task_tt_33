import 'package:equatable/equatable.dart';
import 'package:train_task_tt_33/storages/models/mood.dart';


class MoodState extends Equatable{
  const MoodState({
    this.id,
    this.type,
    this.triggerId,
    this.reasons = const [],
    this.comment = '',
    this.date
  });

  final int? id;
  final int? type;
  final int? triggerId;
  final List<String> reasons;
  final String comment;
  final DateTime? date;

  factory MoodState.fromIsarModel(Mood mood) {
    return MoodState(
        id: mood.id,
        type: mood.type,
        triggerId: mood.triggerId,
        reasons: mood.reasons ?? const [],
        comment: mood.comment ?? '',
        date: mood.date);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, type, triggerId, reasons, comment, date];

  MoodState copyWith({
    int? id,
    int? type,
    int? triggerId,
    List<String>? reasons,
    String? comment,
    DateTime? date
  }) {
   return MoodState(
       id: id ?? this.id,
       type: type ?? this.type,
       triggerId: triggerId ?? this.triggerId,
       reasons: reasons ?? this.reasons,
       comment: comment ?? this.comment,
       date: date ?? this.date
   );
  }

  Mood toIsarModel() {
    return Mood()
        ..type = type
        ..triggerId = triggerId
        ..reasons = reasons
        ..comment = comment
        ..date = date;
  }
}

