import 'package:notez/domain/entities/note.dart';

abstract class NoteRepository {
  Future<List<Note>> getAllNotes();
  Future<Note> getNote({required String uuid});
  Future<void> addNote({required Note note});
  Future<void> updateNote({required int index, required Note note});
  Future<void> deleteNote({required int index});
}
