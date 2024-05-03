import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:intl/intl.dart';
import 'package:notez/data/controller/home_controller.dart';
import 'package:notez/data/model/note.dart';
import 'package:notez/utils/app_theme.dart';
import 'package:notez/views/home/home_views.dart';

class DetailNotePageViews extends StatefulWidget {
  final Note note;

  const DetailNotePageViews({super.key, required this.note});

  @override
  State<DetailNotePageViews> createState() => _DetailNotePageViewsState();
}

class _DetailNotePageViewsState extends State<DetailNotePageViews> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final HomeController _controller = Get.find();

  String createdAt = '';
  String updatedAt = '';

  void checkDataAvailability() {
    // Masuk-masukin data yang dipilih ke dalem text
    titleController.text = widget.note.title.toString();
    descriptionController.text = widget.note.text.toString();

    createdAt = DateFormat('dd MMMM yyyy, hh:mm a').format(
      widget.note.createdAt!,
    );
    updatedAt = DateFormat('dd MMMM yyyy, hh:mm a').format(
      widget.note.updatedAt!,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Cek dan set data note yang dipilih ke dalam tampilan
    checkDataAvailability();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Details',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Get.off(
            () => HomePageViews(),
          ),
          icon: Icon(CupertinoIcons.back, color: kWhite),
        ),
      ),
      body: SafeArea(child: fetchNotesData()),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 16, bottom: 16),
        child: SpeedDial(
          elevation: 1.5,
          icon: Icons.save,
          activeIcon: Icons.close,
          iconTheme: const IconThemeData(color: kWhite),
          backgroundColor: kBlue,
          children: [
            SpeedDialChild(
              child: const Icon(CupertinoIcons.pen, color: kWhite),
              elevation: 1.5,
              backgroundColor: kBlue,
              onTap: () {
                // Note note = Note(
                //   uuid: widget.note.uuid,
                //   title: titleController.text,
                //   text: descriptionController.text,
                //   isPinned: widget.note.isPinned,
                //   createdAt: widget.note.createdAt,
                //   updatedAt: DateTime.now(),
                // );

                // _controller.deleteNote(note.uuid!);
                // _controller.addNote(note);
                // Get.off(() => HomePageViews());

                Get.snackbar('Update', 'Still in development');
              },
            ),
            SpeedDialChild(
              child: const Icon(CupertinoIcons.delete, color: kWhite),
              elevation: 1.5,
              backgroundColor: Colors.red,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Delete Note'),
                      content:
                          const Text('Are you sure want to delete this note?'),
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
                            _controller.deleteNote(
                              widget.note.uuid.toString(),
                            );

                            Get.back();
                            Get.back();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget fetchNotesData() {
    return StreamBuilder<Note>(
      // GET 1 note data pake UUID yg dipilih
      stream: _controller.getSingleNote(widget.note.uuid.toString()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 16, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Created At: $createdAt',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Updated At: $updatedAt',
                      ),
                    ),
                  ],
                ),
              ),
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

        return Container();
      },
    );
  }
}
