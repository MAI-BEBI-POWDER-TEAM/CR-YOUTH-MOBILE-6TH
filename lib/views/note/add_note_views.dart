import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notez/data/controller/home_controller.dart';
import 'package:notez/utils/app_theme.dart';

class AddNotePageViews extends StatefulWidget {
  const AddNotePageViews({super.key});

  @override
  State<AddNotePageViews> createState() => _AddNotePageViewsState();
}

class _AddNotePageViewsState extends State<AddNotePageViews> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final HomeController _controller = Get.find();

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
        child: Container(),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 16, bottom: 16),
        child: FloatingActionButton(
          elevation: 1,
          backgroundColor: kBlue,
          shape: const CircleBorder(),
          onPressed: () {},
          child: const Icon(Icons.save, size: 28, color: kWhite),
        ),
      ),
    );
  }
}
