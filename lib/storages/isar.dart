import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:train_task_tt_33/storages/models/mood.dart';
import 'package:train_task_tt_33/storages/models/trigger.dart';

abstract class AppIsarDatabase {
  static late final Isar _instance;

  static Future<Isar> init() async {
    final dir = await getApplicationDocumentsDirectory();
    return _instance = await Isar.open(
        [MoodSchema, TriggerSchema],
        directory: dir.path,
    );
  }

  static Future<List<Mood>> getMoods() async {
    return await _instance.writeTxn(
        () async => await _instance.moods
            .filter()
            .dateBetween(DateTime.now().subtract(const Duration(days: 3)), DateTime.now().add(const Duration(days: 3)))
            .findAll(),
    );
  }

  static Future<void> addMood(Mood mood) async {
    await _instance.writeTxn(() async => await _instance.moods.put(mood));
  }

  static Future<void> updateMood(int id, Mood newMood) async {
    await _instance.writeTxn(() async {
      final mood = await _instance.moods.get(id);
      if (mood != null) {
        mood
          ..type = newMood.type
          ..triggerId = newMood.triggerId
          ..reasons = newMood.reasons
          ..date = newMood.date;
        return await _instance.moods.put(mood);
      }
    });
  }

  static Future<List<Trigger>> getTriggers() async {
    return await _instance.writeTxn(
          () async => await _instance.triggers.where().findAll(),
    );
  }

  /*static Future<Trigger?> getTrigger(int id) async {
    return await _instance.writeTxn(() async => await _instance.triggers.get(id));
  }*/

  static Future<void> addTrigger(Trigger trigger) async {
    await _instance.writeTxn(
            () async {
              await _instance.triggers.put(trigger);
            }
    );
  }

  static Future<void> updateTrigger(int id, Trigger newTrigger) async {
    await _instance.writeTxn(() async {
      final trigger = await _instance.triggers.get(id);
      if (trigger != null) {
        trigger
          ..name = newTrigger.name
          ..subjects = newTrigger.subjects
          ..comment = newTrigger.comment;
        return await _instance.triggers.put(trigger);
      }
    });
  }

  /*static Future<void> deleteData() async {
    await _instance.writeTxn(() async {
      final startDate = DateTime.now().subtract(const Duration(days: 3));
      final endDate = DateTime.now().add(const Duration(days: 3));
      final moods = await _instance.moods.where().findAll();

      if (moods.isNotEmpty) {
        for (var mood in moods) {
          if (mood.date!.isBefore(startDate) || mood.date!.isAfter(endDate)) {
            if (mood.triggerId != null) {
              _instance.triggers.delete(mood.triggerId!);
            }
            _instance.moods.delete(mood.id);
          }
        }
      }

    });
  }*/



}