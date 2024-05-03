import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notez/data/controller/home_controller.dart';
import 'package:notez/data/model/note.dart';
import 'package:notez/utils/app_theme.dart';
import 'package:notez/views/note/add_note_views.dart';
import 'package:notez/views/note/detail_note_views.dart';

class HomePageViews extends StatefulWidget {
  const HomePageViews({super.key});

  @override
  State<HomePageViews> createState() => _HomePageViewsState();
}

class _HomePageViewsState extends State<HomePageViews> {
  final HomeController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
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
        visible: _controller.noteBox.isNotEmpty,
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
      valueListenable: _controller.noteBox.listenable(),
      builder: (context, notes, _) {
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
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
              ),
              itemCount: notes.length,
              itemBuilder: (context, index) {
                Note data = notes.getAt(index)!;

                return InkWell(
                  onTap: () {
                    log(data.toString(), name: 'home-views');

                    Get.to(
                      () => DetailNotePageViews(
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
                          Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              notes.getAt(index)?.title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(height: 0.5, color: Colors.grey),
                          Container(
                            margin: const EdgeInsets.only(top: 16),
                            child: Text(
                              notes.getAt(index)?.text,
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
          );
        }
      },
    );
  }
}
