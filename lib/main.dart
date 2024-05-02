import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notez/data/controller/home_controller.dart';
import 'package:notez/utils/app_theme.dart';
import 'package:notez/utils/shared_prefs.dart';
import 'package:notez/views/home_views.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPreferenceService.init();
  await Hive.initFlutter();

  Get.lazyPut(() => HomeController());

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TheNotez',
      theme: AppThemeUtils.lightTheme,
      darkTheme: AppThemeUtils.darkTheme,
      home: const NotezSplashScreenViews(),
    );
  }
}

class NotezSplashScreenViews extends StatefulWidget {
  const NotezSplashScreenViews({super.key});

  @override
  State<NotezSplashScreenViews> createState() => _NotezSplashScreenViewsState();
}

class _NotezSplashScreenViewsState extends State<NotezSplashScreenViews> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 3),
      () => Get.off(() => const HomePageViews()),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo-notes.png',
              scale: 0.8,
            ),
            const Text(
              'TheNotez',
              style: const TextStyle(fontSize: 40),
            ),
          ],
        ),
      ),
    );
  }
}
