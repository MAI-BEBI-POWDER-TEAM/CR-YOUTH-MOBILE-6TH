import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notez/data/controller/note_controller.dart';
import 'package:notez/domain/entities/note.dart';
import 'package:notez/utils/app_theme.dart';
import 'package:notez/app/views/note/add_note_views.dart';
import 'package:notez/app/views/note/detail_note_views.dart';

class HomePageViews extends StatefulWidget {
  const HomePageViews({super.key});

  @override
  State<HomePageViews> createState() => _HomePageViewsState();
}

class _HomePageViewsState extends State<HomePageViews> {
  final NoteController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'TheNotez',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Obx(
              () => Switch(
                value: _controller.currentTheme.value == ThemeMode.light,
                onChanged: (val) {
                  _controller.switchTheme();
                  Get.changeThemeMode(_controller.currentTheme.value);
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                inactiveThumbImage: const AssetImage('assets/ic-dark.png'),
                activeThumbImage: const AssetImage('assets/ic-light.png'),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: fetchNotesData(),
      ),
      floatingActionButton: Visibility(
        visible: _controller.notebox.isNotEmpty,
        child: Padding(
          padding: const EdgeInsets.only(right: 16, bottom: 16),
          child: FloatingActionButton(
            elevation: 1,
            backgroundColor: kBlue,
            shape: const CircleBorder(),
            onPressed: () => Get.to(() => const AddNotePageViews()),
            child: const Icon(
              Icons.add,
              size: 32,
              color: kWhite,
            ),
          ),
        ),
      ),
    );
  }

  ValueListenableBuilder fetchNotesData() {
    return ValueListenableBuilder(
      valueListenable: _controller.notebox.listenable(),
      builder: (context, notes, _) {
        log(notes.length.toString());

        if (notes.isEmpty) {
          return Center(
            child: SizedBox(
              height: 260,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: const Text(
                      'Welcome to',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: const Text(
                      'TheNotez',
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 24),
                    child: ElevatedButton(
                      onPressed: () => Get.to(() => const AddNotePageViews()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        fixedSize: const Size(200, 60),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            CupertinoIcons.text_badge_plus,
                            color: kPrimaryWhite,
                            size: 28,
                          ),
                          Text(
                            'New Note',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: kPrimaryWhite,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: GetBuilder<NoteController>(
              builder: (context) => GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                ),
                itemCount: _controller.notebox.length,
                itemBuilder: (context, index) {
                  Note data = notes.getAt(index)!;

                  return InkWell(
                    onTap: () {
                      log(data.toString(), name: 'home-views');

                      Get.to(
                        () => DetailNotePageViews(
                          index: index,
                          note: data,
                        ),
                      );
                    },
                    child: Card(
                      elevation: 1.5,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                onPressed: () {
                                  _controller.switchPinned(data);
                                },
                                icon: Icon(
                                  data.isPinned
                                      ? Icons.bookmark
                                      : Icons.bookmark_border,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                data.title!,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Container(height: 0.5, color: Colors.grey),
                            Container(
                              margin: const EdgeInsets.only(top: 16),
                              child: Text(
                                data.text!,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }
}
