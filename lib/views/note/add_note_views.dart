import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notez/data/controller/home_controller.dart';
import 'package:notez/data/model/note.dart';
import 'package:notez/utils/app_theme.dart';
import 'package:notez/views/home/home_views.dart';
import 'package:uuid/uuid.dart';

class AddNotePageViews extends StatefulWidget {
  const AddNotePageViews({super.key});

  @override
  State<AddNotePageViews> createState() => _AddNotePageViewsState();
}

class _AddNotePageViewsState extends State<AddNotePageViews> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final HomeController _controller = Get.find();
  var uuid = const Uuid();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Notes',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            if (titleController.text.isNotEmpty ||
                descriptionController.text.isNotEmpty) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialog.adaptive(
                    title: const Text('Discard Changes'),
                    content: const Text(
                        'Are you sure to discard this note changes?'),
                    actions: [
                      TextButton(
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: kBlue),
                        ),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                      TextButton(
                        child: const Text(
                          'Yes',
                          style: TextStyle(color: Colors.red),
                        ),
                        onPressed: () {
                          Get.back();
                          Get.back();
                        },
                      ),
                    ],
                  );
                },
              );
            } else {
              Get.back();
            }
          },
          icon: const Icon(CupertinoIcons.back),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(child: buildNoteForms()),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 16, bottom: 16),
        child: FloatingActionButton(
          elevation: 1,
          backgroundColor: kBlue,
          shape: const CircleBorder(),
          onPressed: () async {
            String title = '';
            String text = '';

            if (titleController.text.isEmpty) {
              title = 'Untitled';
            } else {
              title = titleController.text;
            }

            if (descriptionController.text.isEmpty) {
              Get.snackbar(
                'TheNotez',
                'Please enter some text for the notes!',
                backgroundColor: Colors.redAccent.withOpacity(0.5),
              );
            } else {
              text = descriptionController.text;
            }

            if (descriptionController.text.isNotEmpty &&
                titleController.text.isNotEmpty) {
              Note note = Note(
                uuid: uuid.v1(),
                title: title,
                text: text,
                isPinned: false,
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              );

              log(note.toString(), name: 'add-note-views');

              await _controller.addNote(note);
              Get.offAll(() => const HomePageViews());
            }
          },
          child: const Icon(Icons.save, size: 28, color: kWhite),
        ),
      ),
    );
  }

  Column buildNoteForms() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextFormField(
            controller: titleController,
            maxLength: 24,
            style: const TextStyle(fontSize: 24),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Untitled',
              hintStyle: TextStyle(fontSize: 24, color: Colors.grey),
            ),
          ),
        ),
        Container(
          height: 0.5,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextFormField(
            controller: descriptionController,
            maxLength: 200,
            maxLines: 18,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Your Notes',
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
