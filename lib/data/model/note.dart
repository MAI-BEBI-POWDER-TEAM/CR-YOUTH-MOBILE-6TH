import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  String? uuid;
  @HiveField(1)
  final String? title;
  @HiveField(2)
  final String? text;
  @HiveField(3)
  final bool? isPinned;
  @HiveField(4)
  final DateTime? createdAt;
  @HiveField(5)
  final DateTime? updatedAt;

  Note({
    this.uuid,
    this.title,
    this.text,
    this.isPinned,
    this.createdAt,
    this.updatedAt,
  });

  @override
  String toString() {
    return '''
          Note {
            uuid: $uuid
            title: $title
            text: $text
            isPinned: $isPinned
            createdAt: $createdAt
            updatedAt: $updatedAt
          }
          ''';
  }
}
