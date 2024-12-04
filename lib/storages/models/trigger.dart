import 'package:isar/isar.dart';

part 'trigger.g.dart';

@collection
class Trigger {
  Id id = Isar.autoIncrement;

  String? name;
  List<String>? subjects;
  String? comment;

}