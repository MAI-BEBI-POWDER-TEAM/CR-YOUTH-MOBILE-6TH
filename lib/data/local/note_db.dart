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
  static Note getNote(String uuid) => noteBox.values
      .toList()
      .firstWhere((element) => uuid == element.uuid.toString());
  // D. Update Note
  static Future<void> updateNote(Note note) async => await noteBox.put(
        note.uuid,
        note,
      );
  // E. Delete Note
  static Future<void> deleteNote(String uuid) async =>
      await noteBox.delete(uuid);
}
