import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:notez/data/local/note_db.dart';
import 'package:notez/domain/entities/note.dart';
import 'package:notez/domain/usecase/note_usecase.dart';

class NoteController extends GetxController {
  Rx<ThemeMode> currentTheme = ThemeMode.system.obs;
  late Box<Note> notebox;

  NoteUseCase noteUseCase = NoteUseCase();

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

  Future<List<Note>> getAllNotes() async {
    return await noteUseCase.getAllNotes();
  }

  Future<Note> getNote({required String uuid}) async {
    return noteUseCase.getNote(uuid: uuid);
  }

  Future<void> addNote({required Note note}) async {
    await noteUseCase.addNote(note: note);
  }

  Future<void> updateNote({required int index, required Note note}) async {
    await noteUseCase.updateNote(index: index, note: note);
  }

  Future<void> deleteNote({required int index}) async {
    await noteUseCase.deleteNote(index: index);
  }
}
