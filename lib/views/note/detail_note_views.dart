import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notez/data/controller/home_controller.dart';

class DetailNotePageViews extends StatefulWidget {
  final String title;

  const DetailNotePageViews({super.key, required this.title});

  @override
  State<DetailNotePageViews> createState() => _DetailNotePageViewsState();
}

class _DetailNotePageViewsState extends State<DetailNotePageViews> {
  final HomeController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Notes',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
