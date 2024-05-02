import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  final String? title;
  @HiveField(1)
  final String? text;
  @HiveField(2)
  final bool? isPinned;
  @HiveField(3)
  final DateTime? createdAt;
  @HiveField(4)
  final DateTime? updatedAt;

  Note({
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
            title: $title
            text: $text
            isPinned: $isPinned
            createdAt: $createdAt
            updatedAt: $updatedAt
          }
          ''';
  }
}
