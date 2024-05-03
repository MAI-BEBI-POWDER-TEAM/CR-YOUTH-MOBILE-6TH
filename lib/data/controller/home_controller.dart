import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notez/data/local/note_db.dart';
import 'package:notez/data/model/note.dart';

class HomeController extends GetxController {
  Rx<ThemeMode> currentTheme = ThemeMode.system.obs;
  

  void switchTheme() {
    currentTheme.value = currentTheme.value == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
  }

  final noteBox = NoteDB.noteBox;

  Stream<Note> getSingleNote(String uuid) async* {
    yield NoteDB.getNote(uuid);
  }

  Future<void> addNote(Note note) async {
    final Note newNote = Note(
      uuid: note.uuid,
      title: note.title,
      text: note.text,
      isPinned: note.isPinned,
      createdAt: note.createdAt,
      updatedAt: note.updatedAt,
    );

    await NoteDB.addNote(newNote);
  }

  Future<void> updateNote(Note note) async {
    final Note newNote = Note(
      uuid: note.uuid,
      title: note.title,
      text: note.text,
      isPinned: note.isPinned,
      createdAt: note.createdAt,
      updatedAt: note.updatedAt,
    );

    await NoteDB.updateNote(newNote);
  }

  Future<void> deleteNote(String uuid) async {
    await NoteDB.deleteNote(uuid);
  }
}
