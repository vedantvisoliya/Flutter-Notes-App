import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Note {
  @HiveField(0)
  late int id;
  @HiveField(1)
  late String text;

  Note({
    required this.id,
    required this.text,
  });
}