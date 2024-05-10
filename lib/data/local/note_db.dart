import 'package:hive/hive.dart';
import 'package:notez/domain/entities/note.dart';

class NoteDB {
  static Box<Note> noteBox = Hive.box<Note>('notes');

  static Future<void> init() async {
    await Hive.openBox<Note>('notes');
  }

  // CRUD
  // A. Add Note
  static Future<void> addNote(Note note) async {
    await noteBox.add(note);
  }

  // B. Read All Note
  static Future<List<Note>> getAllNotes() async => noteBox.values.toList();

  // C. Read Specific Note
  static Note getNote(String uuid) => noteBox.values
      .toList()
      .firstWhere((element) => uuid == element.uuid.toString());

  // D. Update Note
  static Future<void> updateNote(int index, Note note) async {
    await noteBox.putAt(index, note);
  }

  // E. Delete Note
  static Future<void> deleteNote(int index) async {
    await noteBox.deleteAt(index);
  }
}
