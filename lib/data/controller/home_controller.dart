import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:notez/data/local/note_db.dart';
import 'package:notez/data/model/note.dart';

class HomeController extends GetxController {
  Rx<ThemeMode> currentTheme = ThemeMode.system.obs;
  late Box<Note> notebox;

  void switchPinned(Note note) {
    note.isPinned = !note.isPinned;
    note.save();
  }

  void switchTheme() {
    currentTheme.value = currentTheme.value == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
  }

  @override
  void onInit() async {
    super.onInit();
    notebox = NoteDB.noteBox;
  }

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

  Future<void> updateNote(int index, Note note) async {
    final Note newNote = Note(
      uuid: note.uuid,
      title: note.title,
      text: note.text,
      isPinned: note.isPinned,
      createdAt: note.createdAt,
      updatedAt: note.updatedAt,
    );

    await NoteDB.updateNote(index, newNote);
  }

  Future<void> deleteNote(int index) async {
    await NoteDB.deleteNote(index);
  }
}
