import 'package:hive/hive.dart';
import 'package:notez/data/model/note.dart';

class NoteDB {
  static Box<Note> noteBox = Hive.box<Note>('notes');

  static Future<void> init() async => await Hive.openBox<Note>('notes');

  // CRUD
  // A. Add Note
  static Future<void> addNote(Note note) async => await noteBox.add(note);
  // B. Read All Note
  static List<Note> getAllNotes() => noteBox.values.toList();
  // C. Read Specific Note
  static Note getNote(String title) => noteBox.values
      .toList()
      .firstWhere((element) => title == element.title.toString());
  // D. Update Note
  static Future<void> updateNote(Note note) async => await noteBox.put(
        note.title,
        note,
      );
  // E. Delete Note
  static Future<void> deleteNote(String title) async =>
      await noteBox.delete(title);
}
