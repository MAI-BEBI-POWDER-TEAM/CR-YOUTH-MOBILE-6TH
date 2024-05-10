import 'package:notez/data/local/note_db.dart';
import 'package:notez/domain/entities/note.dart';
import 'package:notez/domain/repositories/note_repository.dart';

class NoteUseCase extends NoteRepository {
  @override
  Future<void> addNote({required Note note}) async {
    await NoteDB.addNote(note);
  }

  @override
  Future<void> deleteNote({required int index}) async {
    await NoteDB.deleteNote(index);
  }

  @override
  Future<List<Note>> getAllNotes() async {
    return await NoteDB.getAllNotes();
  }

  @override
  Future<Note> getNote({required String uuid}) async {
    return NoteDB.getNote(uuid);
  }

  @override
  Future<void> updateNote({required int index, required Note note}) async {
    await NoteDB.updateNote(index, note);
  }
}
