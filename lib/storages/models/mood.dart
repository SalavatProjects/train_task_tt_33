import 'package:isar/isar.dart';

part 'mood.g.dart';

@collection
class Mood {
  Id id = Isar.autoIncrement;

  int? type;
  int? triggerId;
  List<String>? reasons;
  DateTime? date;
}