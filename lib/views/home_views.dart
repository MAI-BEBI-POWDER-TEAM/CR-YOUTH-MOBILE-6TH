import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notez/data/controller/home_controller.dart';
import 'package:notez/utils/app_theme.dart';

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
      appBar: AppBar(
        title: const Text(
          'Home Page',
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
      body: SafeArea(child: Container()),
    );
  }
}
