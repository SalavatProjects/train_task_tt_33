import 'package:equatable/equatable.dart';
import 'package:train_task_tt_33/storages/models/trigger.dart';


class TriggerState extends Equatable{
  const TriggerState({
      this.id,
      this.name,
      this.subjects,
      this.comment
  });

  final int? id;
  final String? name;
  final List<String>? subjects;
  final String? comment;

  factory TriggerState.fromIsarModel(Trigger trigger) {
    return TriggerState(
      id: trigger.id,
      name: trigger.name,
      subjects: trigger.subjects,
      comment: trigger.comment
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, subjects, comment];

  TriggerState copyWith({
    int? id,
    String? name,
    List<String>? subjects,
    String? comment
  }) {
    return TriggerState(
      id: id ?? this.id,
      name: name ?? this.name,
      subjects: subjects ?? this.subjects,
      comment: comment ?? this.comment,
    );
  }

  Trigger toIsarModel() {
    return Trigger()
        ..name = name
        ..subjects = subjects
        ..comment = comment;
  }
}

